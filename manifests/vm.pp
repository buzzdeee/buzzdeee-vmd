# This defined type maintains the vms
define vmd::vm (
  $disk,
  $enable     = true,
  $memory     = '512M',
  $boot       = undef,
  $owner      = undef,
  $interfaces = undef,
) {

  file "/etc/vm.d/vm_${title}.conf" {
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template('vm/vm_instance.conf')
  }

  concat::fragment {
    target  => '/etc/vm.conf',
    content => "include /etc/vm.d/vm_${title}.conf",
    order   => '01',
  }

}
