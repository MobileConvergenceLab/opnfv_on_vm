# opnfv_on_vm

![fuel](https://cloud.githubusercontent.com/assets/10733551/21759160/79e7c922-d685-11e6-8c81-f5b440cd04c7.jpg)

하나 혹은 소수의 물리머신에서 OPNFV-FUEL 설치 연습을 위한 가상 네트워크 생성

## 파일
파일은 3개로 구성되어 있음.

 - opnfv.config: 변수 설정
 - opnfv_net.sh: 가상 네트워크 생성
 - opnfv_clear.sh: 가상 네트워크 삭제
 
## 사용법

1. opnfv_config 수정
2. opnfv_net.sh 실행
3. 작업 후 가상 네트워크 삭제를 위해 opnfv_clear.sh 실행

> [주의] 가상 네트워크를 위한 포트를 자동으로 생성되나 가상머신과 포트를 연결하는 작업는 사용자가 직업 해줘야 함


## 예제 1 - 물리머신 1대

"PC 1"에서 다음과 같이 설정
```sh
# JUMP SERVER NETWORK INFO
JUMP_NET=172.18.0.64
JUMP_GW=172.18.0.65
JUMP_MASK=255.255.255.192
JUMP_MASTER=1

# Physical Interface
PHY_ENABLE=0

PHY_IF_PRIV=eth0

PHY_IF_PUB=eth1

# Number of virtual machines
NUM_NODES=2
```

![example1](https://cloud.githubusercontent.com/assets/10733551/21759162/7fbeef7e-d685-11e6-9e3b-0a285950fbe5.png)

## 예제 2 - 물리머신 2대

"PC 1"에서 다음과 같이 설정
```sh
# JUMP SERVER NETWORK INFO
JUMP_NET=172.18.0.64
JUMP_GW=172.18.0.65
JUMP_MASK=255.255.255.192
JUMP_MASTER=1

# Physical Interface
PHY_ENABLE=1

PHY_IF_PRIV=eth0

PHY_IF_PUB=eth1

# Number of virtual machines
NUM_NODES=2
```

"PC 2"에서 다음과 같이 설정
```sh
# JUMP SERVER NETWORK INFO
JUMP_NET=172.18.0.64
JUMP_GW=172.18.0.65
JUMP_MASK=255.255.255.192
JUMP_MASTER=0

# Physical Interface
PHY_ENABLE=1

PHY_IF_PRIV=eth0

PHY_IF_PUB=eth1

# Number of virtual machines
NUM_NODES=3
```

![example2](https://cloud.githubusercontent.com/assets/10733551/21759163/81a3b91e-d685-11e6-99ee-d5146dd58d23.png)

License
----

Apache License


**MobileConvergence Lab**
