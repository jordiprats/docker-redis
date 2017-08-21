
class { 'redis': }

redis::instance { '6380':
  daemonize => false,
}
