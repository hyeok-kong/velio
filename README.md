# velio
portfolio platform service

## 포트폴리오 제작 웹서비스

### 구조
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
### 사용 기술
 - jsp(css, javascript)
 - java 11
 - MySQL

- - -
### 기능
1. 회원가입 / 로그인
2. 포트폴리오 작성
3. 프로젝트 작성
4. 포트폴리오 PDF로 변환
5. 관리자 권한(모든 유저 및 포트폴리오 관리 가능)
