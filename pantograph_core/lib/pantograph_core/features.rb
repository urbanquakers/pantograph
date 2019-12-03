require_relative 'feature/feature'

PantographCore::Feature.register(env_var: 'PANTOGRAPH_ITUNES_TRANSPORTER_USE_SHELL_SCRIPT',
                           description: 'Use iTunes Transporter shell script')
