# docker-radius

FreeRADIUS 3.0.9 with multiOTP 4.3.2.6

mount the following volumes and populate with config files:

          - "/opt/multiotp/config"
          - "/opt/multiotp/users"
          - "/etc/raddb"

Follow the multiOTP README for instruction on how to set up FreeRADIUS for OTP.
