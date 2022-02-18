import numpy as np
import matplotlib.pyplot as plt

A = 13.4    # Cross-sectional area of tank in [m²]
h_min = 0   # minimum height level in [m]
h_max = 15  # max height level in [m]
rho = 145   # Wood chip density [kg/m³]
u = 50      # Control signal to feed screw [%]
Ks = 0.5    # Feed screw gain (capacity) [(kg/s)/%]
w_in = 25   # Wood chips flow into tank (from belt) [kg/s]
w_out = 25  # Wood chips outflow from tank
t_delay = 250   # Transport time (time delay) on conveyor belt [s]

Ts = 1.0    # Time step in [s]
t_start = 0     # Time start in [s]
t_stop = 5000   # Time stop in [s]
N_sim = int((t_stop - t_start) / Ts) + 1  # Number of simulation

# Preallocation of arrays for plotting
t_array = np.zeros(N_sim)   # Array for time
h_array = np.zeros(N_sim)   # Array for height level in tank

h_k = h_init = 10   # Initial height level in tank [m]

# Preallocation of array for time-delay:
Nd = int(round(t_delay/Ts)) + 1
delay_array = np.zeros(Nd) + u

u_array = np.zeros(N_sim)

for k in range(0, N_sim):
    # state limitation
    h_k = np.clip(h_k, h_min, h_max)

    t_k = k * Ts    # Time

    u_in_k = u
    # Excitation:
    if 1000 <= t_k:
        u_in_k = 55

    # Time delay:
    u = delay_array[-1]
    delay_array[1:] = delay_array[0:-1]
    delay_array[0] = u_in_k
    # print(delay_array)

    # Time-derivative
    dh_dt_h = ((Ks * u) - w_out) * (1 / (rho * A))

    # Sate updates using the Euler method:
    h_kp1 = h_k + dh_dt_h * Ts

    # Updating arrays for plotting:
    t_array[k] = t_k
    h_array[k] = h_k
    u_array[k] = u

    # Time shift:
    h_k = h_kp1

# Plotting

slope = np.diff(h_array[1250:5001]).mean()
print(f'Slope = {slope}')

plt.close('all')    # Closes all figures before plotting
plt.figure(num=1, figsize=(12, 9))

# creating plot time t [s] vs level h [m]
plt.subplot(2, 1, 1)
plt.plot(t_array, h_array)
plt.grid()
plt.xlabel('t [s]')
plt.ylabel('[m]')
plt.legend(labels=('Level h',))

plt.subplot(2, 1, 2)
plt.plot(t_array, u_array, 'r')
plt.plot(t_array, u_array, 'g')
plt.grid()
plt.xlabel('t [s]')
plt.ylabel('Screw signal u(t - t_delay)')
plt.legend(labels=('Inflow F_in', 'Outflow F_out'))

plt.show()
