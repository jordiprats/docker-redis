
class { 'redis': }

redis::instance { '6379':
  daemonize => false,
}
