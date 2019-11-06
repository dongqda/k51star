# oilNav
 최적 주유소 길안내 서비스

## 홍보영상
<iframe width="560" height="315" src="https://www.youtube.com/embed/gGkLFVYjUiE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
[![Alt text](https://www.youtube.com/embed/gGkLFVYjUiE.jpg)](https://www.youtube.com/watch?v=VID)


## INDEX

+ [ROLE](#ROLE)
+ [I. 개발환경-Development Envirenment](#I-개발환경-Development-Environment)
+ [II. 설정-Setup](#II-설정-Setup)
+ [III. 레이아웃-Layout](#III-레이아웃-Layout)
+ [IV.기능-Function](#IV-기능-Function)



## ROLE

| 팀장   | 기획                   | 개발                   | QA     |
| ------ | ---------------------- | ---------------------- | ------ |
| 박정원 | 김범현, 박정원, 이동규 | 김범현, 박정원, 이동규 | 박정원 |



## I. 개발환경-Development Environment

![SpringBoot_Vue](md_pic/springBoot_vue.png)

+ IDE : Eclipse
+ Atom
+ SpringBoot 2
+ Vue cli 3
+ bootstarp vue
+ Java
+ Gradle
+ MariaDB
+ [AQueryTool](http://aquerytool.com/)
+ Windows



## II. 설정-Setup

##### 1. Go to [SpringBoot Initializr](https://start.spring.io/)

![SpringBoot Initializr](md_pic/SpringBootInitializr.png)

##### 2. Add Dependencies

+ Spring Web
+ Thymeleaf

##### 3. Generate and Unzip

##### 4. Import Gradle Project 

![importGradle](md_pic/importGradle.png)

![basicGradlePj](md_pic/basicGradlePj.png)

##### 5.  Go to [node.js Download](https://nodejs.org/en/download/)

![downloadNodejs](md_pic/downloadNodejs.png)

##### 6.  명령프롬포트 실행 1

+ Windows 

```
  npm i -g @vue/cli // vue-cli 3.x
  npm i -g vue-cli // vue-cli 2.x
```


##### 7. 환경변수 설정

+ 시스템 PATH에 ```C:\Users\유저명\AppData\Roaming\npm``` 경로 추가

##### 8.  명령프롬포트 실행

+ Move Gradle Project Directory

```
  cd oilnav
```

+ Create Project

```
	vue create '프로젝트 명' // vue-cli 3.X
    vue init webpack '프로젝트 명' // vue-cli 2.X
```

 + Build

```
    cd frontend
    npm install
    npm run serve
```

##### 10. Run in local Server

```
    npm run serve // vue-cli 3.x
    npm run dev // vue-cli 2.x
```

##### 11. Create vue.config.js 

![vueConfigJs](md_pic/vueConfigJs.png)

```
    module.exports = {  
      outputDir: "../src/main/resources/static",  
      indexPath: "../static/index.html",  
      devServer: {  
        proxy: "http://localhost:8080"  
      },  
      chainWebpack: config => {  
        const svgRule = config.module.rule("svg");    
        svgRule.uses.clear();    
        svgRule.use("vue-svg-loader").loader("vue-svg-loader");  
      }  
    };
```

+ outputDir은 npm run build로 빌드 시 파일이 생성되는 위치
+ indexPath는 index.html 파일이 생성될 위치를 지정
+ devServer는 Back-End( Spring Boot의 내장 was의 주소)

##### 12. Maria DB Setting in application.properties

```
    #datasource
    spring.datasource.driverClassName=org.mariadb.jdbc.Driver
    spring.datasource.url=jdbc:mariadb://localhost:3306/oilNav
    spring.datasource.username=root
    spring.datasource.password=password
```

##### 13. Go to http://localhost:8080/

![startVue](md_pic/startVue.png)

## III. 레이아웃-Layout

##### 1. Use template

![vuetify](md_pic/template.png)



## IV. 기능-Function

