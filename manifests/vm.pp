# This defined type maintains the vms
define vmd::vm (
  $disk,
  $disksize   = '20G',
  $enable     = true,
  $memory     = '512M',
  $boot       = undef,
  $owner      = undef,
  $interfaces = undef,
) {

  file { "/etc/vm.d/vm_${title}.conf":
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template('vmd/vm_instance.conf.erb')
  }

  concat::fragment { "include_vm_${title}":
    target  => '/etc/vm.conf',
    content => "include /etc/vm.d/vm_${title}.conf\n",
    order   => '01',
  }

  exec { "create_diskimage_for_${title}":
    command => "/usr/sbin/vmctl create -s ${disksize} ${disk}",
    creates => $disk,
    require => File["/etc/vm.d/vm_${title}.conf"],
  }

  exec { "load_vm_config_${title}":
    command     => "/usr/sbin/vmctl load /etc/vm.d/vm_${title}.conf",
    refreshonly => true,
    subscribe   => File["/etc/vm.d/vm_${title}.conf"],
    require     => Exec["create_diskimage_for_${title}"],
  }

}
