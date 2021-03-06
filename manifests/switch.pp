# This defined type maintains the switches
define vmd::switch (
  $interface     = 'bridge0',
  $enable        = true,
  $group         = undef,
  $locked_lladdr = false,
  $rdomain       = undef,
  $forwarding    = true,
) {

  file { "/etc/vm.d/switch_${title}.conf":
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template('vmd/switch_instance.conf.erb')
  }

  concat::fragment { "include_switch_${title}":
    target  => '/etc/vm.conf',
    content => "include /etc/vm.d/switch_${title}.conf\n",
    order   => '10',
  }

  exec { "load_switch_config_${title}":
    command     => "/usr/sbin/vmctl load /etc/vm.d/switch_${title}.conf",
    refreshonly => true,
    subscribe   => File["/etc/vm.d/switch_${title}.conf"],
  }

}
