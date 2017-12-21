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
    content => template('vm/switch_instance.conf.erb')
  }

  concat::fragment {
    target  => '/etc/vm.conf',
    content => "include /etc/vm.d/switch_${title}.conf",
    order   => '10',
  }

}
