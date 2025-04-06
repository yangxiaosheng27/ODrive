# 持久化参数
odrv0.config.brake_resistance = 0

odrv0.axis0.config.enable_sensorless_mode = False
odrv0.axis0.motor.config.pole_pairs = 7
odrv0.axis0.motor.config.motor_type = MOTOR_TYPE_HIGH_CURRENT
odrv0.axis0.motor.config.current_lim = 10
odrv0.axis0.motor.config.calibration_current = 1
odrv0.axis0.motor.config.resistance_calib_max_voltage = 2
odrv0.axis0.motor.config.requested_current_range = 60
odrv0.axis0.motor.config.torque_constant = 0.04 #8.27 / motor_param["kv"]
odrv0.axis0.motor.config.current_control_bandwidth = 2000
odrv0.axis0.controller.config.control_mode = CONTROL_MODE_VELOCITY_CONTROL
odrv0.axis0.controller.config.input_mode = INPUT_MODE_PASSTHROUGH
odrv0.axis0.controller.config.inertia = 0
odrv0.axis0.controller.config.vel_limit = 100
odrv0.axis0.controller.config.vel_integrator_gain = 0.03
odrv0.axis0.controller.config.vel_gain = 0.02
odrv0.axis0.encoder.config.mode = ENCODER_MODE_INCREMENTAL
odrv0.axis0.encoder.config.cpr = 4096*4
odrv0.axis0.encoder.config.calib_range = 0.02
odrv0.axis0.encoder.config.bandwidth = 1000

odrv0.axis1.config.enable_sensorless_mode = False
odrv0.axis1.motor.config.pole_pairs = 10
odrv0.axis1.motor.config.motor_type = MOTOR_TYPE_HIGH_CURRENT
odrv0.axis1.motor.config.current_lim = 10
odrv0.axis1.motor.config.calibration_current = 1
odrv0.axis1.motor.config.resistance_calib_max_voltage = 2
odrv0.axis1.motor.config.requested_current_range = 60
odrv0.axis1.motor.config.torque_constant = 0.04 #8.27 / motor_param["kv"]
odrv0.axis1.motor.config.current_control_bandwidth = 2000
odrv0.axis1.controller.config.control_mode = CONTROL_MODE_VELOCITY_CONTROL
odrv0.axis1.controller.config.input_mode = INPUT_MODE_PASSTHROUGH
odrv0.axis1.controller.config.inertia = 0
odrv0.axis1.controller.config.vel_limit = 100
odrv0.axis1.controller.config.vel_integrator_gain = 0.03
odrv0.axis1.controller.config.vel_gain = 0.03
odrv0.axis1.encoder.config.mode = ENCODER_MODE_INCREMENTAL
odrv0.axis1.encoder.config.cpr = 4096*4
odrv0.axis1.encoder.config.calib_range = 0.02
odrv0.axis1.encoder.config.bandwidth = 1000

odrv0.save_configuration()

# 无传感控制
#odrv0.axis0.sensorless_estimator.config.pm_flux_linkage = 5.51328895422 / (7 * 980)
#odrv0.axis0.config.enable_sensorless_mode = True
#odrv0.save_configuration()

# axis0 速度控制
odrv0.axis0.requested_state = AXIS_STATE_CLOSED_LOOP_CONTROL
odrv0.axis0.controller.input_vel = 2

# axis1 速度控制
odrv0.axis1.requested_state = AXIS_STATE_CLOSED_LOOP_CONTROL
odrv0.axis1.controller.input_vel = -2

# axis1 位置控制
odrv0.axis1.controller.config.pos_gain = 200
odrv0.axis1.controller.config.vel_gain = 0.05
odrv0.axis1.controller.config.vel_integrator_gain = 0
odrv0.axis1.controller.config.input_mode = INPUT_MODE_POS_FILTER
odrv0.axis1.controller.config.control_mode = CONTROL_MODE_POSITION_CONTROL
odrv0.axis1.requested_state = AXIS_STATE_CLOSED_LOOP_CONTROL
odrv0.axis1.controller.input_pos = 0

# 清除错误状态
dump_errors(odrv0)
odrv0.axis0.requested_state = AXIS_STATE_IDLE
odrv0.axis1.requested_state = AXIS_STATE_IDLE
odrv0.clear_errors()
dump_errors(odrv0)

# 重启
odrv0.reboot()
