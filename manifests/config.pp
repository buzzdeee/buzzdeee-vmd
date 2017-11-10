# This class maintains the vmd config file
class vmd::config () {

  concat { '/etc/vm.conf':
    ensure => 'present',
  }

  file { '/etc/vm.d':
    ensure => 'directory',
    owner  => 'root',
    group  => 'wheel',
    mode   => '0755',
  }

}
