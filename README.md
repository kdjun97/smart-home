# 🏡 Smart Home

집의 전력을 모니터링 및 컨트롤 해보기.  

## 들어가기 전...  

[기능 검증 프로젝트](https://github.com/kdjun97/swift-mqtt-test)  
[Blog Link](https://kdjun97.github.io/iot/smart-home-project/)  

## 개발 환경  

Raspberry-Pi5 OS: **Ubuntu 24.04 LTS 64-bit**  
mosquitto: **2.0.18**  
paho-mqtt: **2.1.0**  
python: **3.12.3**  
smart plug: **Shelly Plus Plug S**  
Swift: **5.10**  
Xcode: **15.4**  
Tuist: **4.13.0**  
CocoaMQTT  

---  

## 흐름 설계  

![MQTT Flow](/smart-home/Assets/mqtt_flow.jpeg)  

---  

## Raspberry Pi5 설정  

#### 필수 패키지 설치  

`mosquitto`, `paho-mqtt`(확인용), `python` 설치  

```  
sudo apt install mosquitto -y  
pip install paho-mqtt  
```  

**mosquitto-clients vs paho-mqtt**  

`mosquitt-client`: 명령줄 도구로 MQTT 메시지를 발행하고 구독하는 데 사용됨  
`paho-mqtt`: 다양한 언어에서 MQTT 클라이언트를 구현할 수 있는 프로그래밍 라이브러리 (Python, C, Java 등)  

이번 프로젝트에서는 pub, sub이 제대로 동작하는지 확인하기 위해 `paho-mqtt`를 사용 (저번 검증 프로젝트에서 썼기 때문)  

#### mosquitto.conf 설정  

[mosquitto.conf source code](https://github.com/kdjun97/smart-home/blob/development/Mosquitto/mosquitto.conf)  

**주요 설정**  

- `bind_address`: 예전에는 bind_address로 브로커 주소를 지정할 수 있었으나, 현재 버전에서는 bind_address가 deprecated되어, `0.0.0.0`처럼 설정되기에 별도로 브로커 서버 주소를 입력할 필요가 없음.  
- `log_dest file {myMosquittoLogPath}`: 로그 파일을 지정한 경로에 저장하도록 설정.
- `log_type all`: 모든 유형의 로그 메시지를 출력하도록 설정.
- `로그 파일 관리`: 로그 파일이 계속 쌓이므로, 7일 주기로 로그를 삭제하는 방법을 채택. (CCTV와 같이 주기적으로 삭제되는 규칙을 적용)  
    - `cron`을 사용해 7일 이상된 로그 파일을 삭제하는 쉘 스크립트를 작성.
- `listener {myPort}`: 포트를 지정.  
- `allow_anonymous false`: 인증되지 않은 클라이언트가 브로커에 연결되지 않도록 설정.  
    - `$ mosquitto_passwd -c {myPasswordFilePath} username`: 비밀번호 파일을 생성.  
- `password_file {myPasswordFilePath}`: 사용자 인증을 위한 비밀번호 파일 경로 지정.  

## mosquitto 실행  

**mosquitto service 실행(background)**  
- 시작  
```  
systemctl start mosquitto
```  
- 상태 확인  
```  
systemctl status mosquitto
```  
- 중지 
```  
systemctl stop mosquitto
```  

**로그  확인**  
```  
cat {yourLogPath}
```  

---  

## smart plug 설정  

**shelly 설정**  

장비 AP모드에서 장비에 접속 > admin 페이지 > MQTT broker setting  
토픽은 아래에서 확인  

[MQTT | Shelly Technical Document](https://shelly-api-docs.shelly.cloud/gen2/ComponentsAndServices/Mqtt/)  
[Shelly - RPC Protocol](https://shelly-api-docs.shelly.cloud/gen2/General/RPCProtocol)  

> RPC(Remote Procedure Call, 원격 프로시저 호출)은 네트워크를 통해 다른 컴퓨터나 프로세스에서 실행되는 함수를 호출하는 통신 방식. 로컬에서 함수를 호출하듯이 원격 시스템의 함수를 실행할 수 있도록 해 주며, 분산 시스템에서 많이 사용.  

---   