<link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/webjars/bootstrap/3.2.0/css/bootstrap.min.css'>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel='stylesheet' type="text/css" href='${pageContext.request.contextPath}/webjars/select2/4.0.3/css/select2.min.css'>
<link rel='stylesheet' type="text/css" href="${pageContext.request.contextPath}/webjars/sweetalert/1.0.0/sweetalert.css"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/webjars/jquery/2.1.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/webjars/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/webjars/select2/4.0.3/js/select2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/webjars/sweetalert/1.0.0/sweetalert.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/pdfjs/build/pdf.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/js/pdfobject.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/js/report.js"></script>
<style>
    .content {
        padding-left: 25px;
        padding-right: 25px;
    }
    
    .wrapper {
        margin-left: 300px;
    }
    
    .big-checkbox {
        width: 25px; 
        height: 25px;
    }
    
    .big-checkbox + label {
        font-size: 25px;
    }
    
    .btn-report {
        color: white;
        font-size: 25px;
        padding: 30px 0;
        width: 60%;
        height: 20%;
    }
    
    .btn-report:hover, .btn-report:focus {
        color: white;
        text-decoration: none;
    }
    
    hr {
        border-top: 1px solid darkgray;
    }
    
    textarea {
        resize: none;
    }
    
    .pdfobject-container {
            width: 100%;
            height: 600px;
            margin: 2em 0;
    }
    .pdfobject { border: solid 1px #666; }
    
    .nav-side-menu .material-icons{
        padding-right: 35px;
        padding-top: 10px;
        font-size: 30px;
    }
    
    .nav-side-menu {
        /*overflow: auto;*/
        font-family: verdana;
        font-size: 20px;
        font-weight: 200;
        background-color: rgb(135,202,182);
        position: fixed;
        top: 0px;
        width: 300px;
        height: 100%;
        color: #e1ffff;
      }
      .nav-side-menu .brand {
        background-color: rgb(0,119,198);
        line-height: 50px;
        display: block;
        text-align: center;
        font-size: 14px;
      }
      .nav-side-menu .toggle-btn {
        display: none;
      }
      .nav-side-menu ul,
      .nav-side-menu li {
        list-style: none;
        padding: 0px;
        margin: 0px;
        line-height: 35px;
        cursor: pointer;
        background-color: rgb(94,151,103);
        /*    
          .collapsed{
             .arrow:before{
                       font-family: FontAwesome;
                       content: "\f053";
                       display: inline-block;
                       padding-left:10px;
                       padding-right: 10px;
                       vertical-align: middle;
                       float:right;
                  }
           }
      */
      }
      .nav-side-menu ul :not(collapsed) .arrow:before,
      .nav-side-menu li :not(collapsed) .arrow:before {
        font-family: FontAwesome;
        content: "\f078";
        display: inline-block;
        padding-left: 10px;
        padding-right: 10px;
        vertical-align: middle;
        float: right;
      }
      .nav-side-menu ul .active,
      .nav-side-menu li .active {
        border-left: 3px solid #d19b3d;
        background-color: rgb(0,74,101);
      }
      .nav-side-menu ul .sub-menu li.active,
      .nav-side-menu li .sub-menu li.active {
        color: #d19b3d;
      }
      .nav-side-menu ul .sub-menu li.active a,
      .nav-side-menu li .sub-menu li.active a {
        color: #d19b3d;
      }
      .nav-side-menu ul .sub-menu li,
      .nav-side-menu li .sub-menu li {
        background-color: #181c20;
        border: none;
        line-height: 28px;
        border-bottom: 1px solid #23282e;
        margin-left: 0px;
      }
      .nav-side-menu ul .sub-menu li:hover,
      .nav-side-menu li .sub-menu li:hover {
        background-color: #020203;
      }
      .nav-side-menu ul .sub-menu li:before,
      .nav-side-menu li .sub-menu li:before {
        font-family: FontAwesome;
        content: "\f105";
        display: inline-block;
        padding-left: 10px;
        padding-right: 10px;
        vertical-align: middle;
      }
      .nav-side-menu li {
        padding-left: 0px;
        border-left: 3px solid #2e353d;
        border-bottom: 1px solid #23282e;
      }
      .nav-side-menu li a {
        text-decoration: none;
        color: #ffffff;
        width: 100%;
        display: block;
      }
      .nav-side-menu li a i {
        padding-left: 10px;
        width: 20px;
        padding-right: 20px;
      }
      .nav-side-menu li:hover {
        border-left: 3px solid #d19b3d;
        background-color: rgb(0,74,101);
        -webkit-transition: all 1s ease;
        -moz-transition: all 1s ease;
        -o-transition: all 1s ease;
        -ms-transition: all 1s ease;
        transition: all 1s ease;
      }
      @media (max-width: 767px) {
        .nav-side-menu {
          position: relative;
          width: 100%;
          margin-bottom: 10px;
        }
        .nav-side-menu .toggle-btn {
          display: block;
          cursor: pointer;
          position: absolute;
          right: 10px;
          top: 10px;
          z-index: 10 !important;
          padding: 3px;
          background-color: #ffffff;
          color: #000;
          width: 40px;
          text-align: center;
        }
        .brand {
          text-align: left !important;
          font-size: 22px;
          padding-left: 20px;
          line-height: 50px !important;
        }
      }
      @media (min-width: 767px) {
        .nav-side-menu .menu-list .menu-content {
          display: block;
        }
      }
      body {
        margin: 0px;
        padding: 0px;
      }

</style>
