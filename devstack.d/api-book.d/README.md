Vagrant w/ devstack heat demo
====

## description
このファイルは、api本を書くためheatを使いたくて自宅用に作ったもの。  
オレオレ度合いが強すぎてどうしようもないけど参考にはなると思うのでつかってね。  
他にも使えるvagrant + devstackはあると思うし。  

## release info
v0.1 とりあえず、vagrant fileとセットで使える

#### work in progress
* ansible連携
  * invent fileの作成
  * playbookの作成
  * 手動で実行できることを確認してvagrantと連携  


### vagrant file
```
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.42.2"
  config.vm.network "public_network"
  config.vm.provider "virtualbox" do |vb|
     vb.memory = "8192"
   end
end
```
### Configuration for apt repos
* aptの設定ファイルの変更

  ```
cat << _EOF_ >> /etc/apt/apt.conf
Acquire::http::proxy "http://192.168.10.202:3142";
_EOF_
```

* apt-get update
  
  ```
  $ sudo apt-get update
  ```

### git clone
* 一般的なもの

```
$ sudo apt-get install git
$ git clone https://gist.github.com/8bba4ba06da178107cca.git
$ git clone https://github.com/openstack-dev/devstack.git -b stable/juno

```

### copy localrc file to devestack 
```
$ cp 8bba4ba06da178107cca/local.conf.apibook devstack/localrc
```

### execute stack!!

```
$ cd devstack
$ ./stack.sh
```

### heat test
source openrc
heat stack-list
nova flabor-list
nova keypair-add heat_key > heat_key.priv
chmod 600 heat_key.priv
heat stack-create teststack -u http://git.openstack.org/cgit/openstack/heat-templates/plain/hot/F20/WordPress_Native.yaml -P key_name=heat_key -P image_id=Fedora-x86_64-20-20140618-sda

### heat ui integration
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
 $ nova secgroup-add-rule default tcp 80 80 0.0.0.0/0
 $ nova secgroup-list-rules default


##### Reference
http://www.cloudsoftcorp.com/blog/2013/05/getting-started-with-heat-devstack-vagrant/
