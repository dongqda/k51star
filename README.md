# OILODI(오일오디) → 링크 : [oilodi.shop](http://pjtoilodi.herokuapp.com/)
 최적 주유소 길안내 서비스 

## Video
[유튜브링크](https://www.youtube.com/watch?v=gGkLFVYjUiE)

![FullVideo](/md_pic/fullVideo.gif)


## INDEX

+ [ROLE](#ROLE)
+ [I. 개발환경-Development Envirenment](#I-개발환경-Development-Environment)
+ [II. 설정-Setup](#II-설정-Setup)
+ [III. 레이아웃-Layout](#III-레이아웃-Layout)
+ [IV. 기능-Function](#IV-기능-Function)
+ [V. 링크-LInk](#V-링크-Link)
+ [VI. 프로젝트를 마치며](#VI-프로젝트를-마치며)



## ROLE

| 팀장   | 기획                       | 개발                       | QA     |
| ------ | -------------------------- | -------------------------- | ------ |
| 박정원 | 김범현, 박정원, **이동규** | 김범현, 박정원, **이동규** | 박정원 |

```
1. 홈페이지의 전반적인 디자인
2. API와 DB에서 불러온 정보를 사용자가 보기 쉽게 정리하여 화면에 표시
3. 프로젝트 이슈관리
4. readme.md 및 영상 제작
```





## I. 개발환경-Development Environment

![SpringBoot_jsp](md_pic/springBoot_jsp.png)

+ IDE : Eclipse
+ SpringBoot 2.2.0
+ bootstarp4
+ Java
+ Gradle
+ MariaDB
+ [AQueryTool](http://aquerytool.com/)
+ Windows



## II. 설정-Setup

##### 1. Go to [SpringBoot Initializr](https://start.spring.io/)

![SpringBoot Initializr](md_pic/springInitializer.png)

##### 2. Add Dependencies

+ Spring Web
+ Thymeleaf

##### 3. Generate and Unzip

##### 4. Import Gradle Project 

![importGradle](md_pic/importGradle.png)

##### 5. Maria DB Setting in application.properties

```
    #datasource
    spring.datasource.driverClassName=org.mariadb.jdbc.Driver
    spring.datasource.url=jdbc:mariadb://localhost:3306/oilodi
    spring.datasource.username=root
    spring.datasource.password=password
```

##### 13. Go to http://localhost:8080/

![startVue](md_pic/startSpringboot.png)



## III. 레이아웃-Layout

![layout](/md_pic/layout.gif)


## IV. 기능-Function

###### 3초뒤 영상이 시작됩니다.

![function](/md_pic/function.gif)



##### 1. 주유소 추천

###### 			     1) 거리순

###### 			     2) 가격순

###### 		     3) 최적순(거리, 가격, 그리고 차량연비를 이용)



##### 2. 주유소 정보

###### 	     1) 카드 할인정보

###### 	     2) 오피넷에서 제공하는 10여가지의 유가정보 제공 



##### 3. 네비게이션 기능

###### 	     원하는 주유소 선택 후 안내 시작을 누르면 네비게이션 어플로 자동연결 후 안내시작





## V. 링크-Link

[oilodi.shop](http://pjtoilodi.herokuapp.com/)



## VI. 프로젝트를 마치며

##### "문한짝 바퀴 없는 페라리보다 풀옵션의 소나타로"

![Car](/md_pic/Car.png)

이전에 친구 한명과 [projectDuo](https://github.com/Jungwon0110/projectDuo)라는 프로젝트를  진행하였습니다. 프로젝트 목표는 **취업을 준비하는 대학생 예비 개발자를 위한 홈페이지**였습니다. 

주요 기능으로는

​	1) 포트폴리오 관리

​	2) [Trello](https://trello.com/)같은 애자일 보드

​	3) 이력서 관리

​	4) 개발자간 소통 및 질의응답 게시판

​	5) 기업정보 열람

​	6) 영상회의 기능

​	7) 챗봇기능 

​	8) 유저간 실시간 채팅기능

하지만 ~~위의 기능 중 50%도 완성하지 못했고~~, 현재 Github repository에 폐가처럼 남았있습니다.

위 프로젝트를 진행하면서 **기획의 중요성**을 알게되었고, 다음 프로젝트에서 개선해보고자 

OILODI를 기획하였습니다.



**"보다나은 편의성으로 고객을 이해시켜라"**

이번 프로젝트는 **완성도와 사용자 편의성**을 중점으로 개발을 진행하였습니다.

사용자에게 꼭 필요한 기능(최적주유소를 안내)만을 제공하고, 기능을 조금씩 추가하였습니다.

프론트 엔드를 맡은 저는 이번 프로젝트를 하면서 오피넷 api에서 받아온 자료를 사용자가 보기쉬운

정보로 바꾸는 것이 가장 어려웠습니다. 아무리 좋은 기능이라도 사용자가 편리하게 사용할 수 없다면 그 프로그램은 사람들에게 외면되기 마련입니다.

<img src="/md_pic/mainPage.png" style="width:200px">

그래서 첫화면은 사람들에게 이 홈페이지의 설명을 적어주고, 자연스럽게 Enter버튼 클릭으로

그 기능을 바로 사용가능하게 해서 이용자들이 편리하게 사용하게끔 구성하였고, 

기본기능 이외에 추가로 주유소 정보를 제공하는 페이지에서는 중요한 순서대로 상하로 정보를

배치해서 사용자가 자연스럽게 정보를 이용할 수 있게 하였습니다. 

그리고 네비게이션을 위해 모바일 기기의 이용이 더 많을 것으로 생각되어 홈페이지를 모두 반응형으로 제작하여, 
모바일에서 사용도 무리 없이 가능하게 제작하였습니다.



```
기획과 UI, UX의 중요성을 직접 경험할 수 있는 좋은 프로젝트 경험이었고, 
위 프로젝트로 웹 개발에 좀 더 자신감이 생겼습니다. 
제작 후에 로컬로 테스트는 해봤지만 완성 후 배포까지 한 프로젝트는 이번이 처음이었습니다. 
이제 한걸음이지만 좀 더 디테일한 개발자가 될 수있게 만들어준 프로젝트, 
그리고 온전히 디자인과 프론트엔드 개발에만 집중하게 도와준 팀원들로부터 협업의 중요성도 알게 되었던 프로젝트였습니다.  
```



