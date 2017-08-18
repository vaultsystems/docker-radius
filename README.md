# docker-radius

FreeRADIUS 3.0.13 with multiOTP 5.0.4.8

mount the following volumes and populate with config files:

          - "/opt/multiotp/config"
          - "/opt/multiotp/users"
          - "/etc/raddb"

Follow the multiOTP README for instruction on how to set up FreeRADIUS for OTP.
