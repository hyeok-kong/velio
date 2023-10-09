# velio
portfolio platform service

## 포트폴리오 제작 웹서비스

## 구조
```
C:.
├─.settings
├─build
│  └─classes
│      └─bean
│          ├─dao
│          ├─dto
│          └─util
└─src
    └─main
        ├─java
        │  └─bean
        │      ├─dao
        │      ├─dto
        │      └─util
        └─webapp
            ├─common
            ├─imagePath
            ├─META-INF
            ├─resources
            │  ├─css
            │  └─javascript
            ├─service
            │  ├─portfolio
            │  ├─project
            │  ├─shared
            │  └─user
            ├─view
            └─WEB-INF
                └─lib
```
## 사용 기술
 - jsp(css, javascript)
 - java 11
 - MySQL

- - -
## 기능
1. 회원가입 / 로그인
2. 포트폴리오 작성
3. 프로젝트 작성
4. 포트폴리오 PDF로 변환
5. 관리자 권한(모든 유저 및 포트폴리오 관리 가능)

## 시스템 구성
![image](https://github.com/hyeok-kong/velio/assets/70522355/9116d040-8267-4a29-911d-b1cbdfe75efe)

## DB 스키마
![image](https://github.com/hyeok-kong/velio/assets/70522355/7a6291c5-dd50-4579-a048-8f5c2b79bc20)

## 화면 및 기능
### 1. 메인 페이지
![image](https://github.com/hyeok-kong/velio/assets/70522355/eee593ec-1d59-4f05-894b-e4f176ff5f85)
### 2. 로그인 후
![image](https://github.com/hyeok-kong/velio/assets/70522355/b8bd1899-e5cf-47c2-9909-1dd96423d20a)
### 3. 마이 페이지(포트폴리오 작성)
![image](https://github.com/hyeok-kong/velio/assets/70522355/bee7eca6-4f38-4c45-8ca8-edd1e3f08c97)
### 4. 프로젝트 작성
![image](https://github.com/hyeok-kong/velio/assets/70522355/2e3585cd-2e46-4b4f-a3b7-7b5bb6496478)
### 5. 즐겨찾기
![image](https://github.com/hyeok-kong/velio/assets/70522355/c1a66ee6-a354-4291-9144-cfbe1444275c)
### 6. 태그로 검색기능
![image](https://github.com/hyeok-kong/velio/assets/70522355/fc4d0ece-c340-4a7c-b781-5ea4d3cbde3a)
### 7. 포트폴리오 PDF로 저장
![image](https://github.com/hyeok-kong/velio/assets/70522355/b9a30fc4-571b-438f-9a44-3d87ab881a5c)
### 8. 관리자 계정(포트폴리오 수정/삭제, 회원 추방 등 가능)
![image](https://github.com/hyeok-kong/velio/assets/70522355/ab81ddb0-d7d5-4ada-b409-1173adb5a68d)
   
