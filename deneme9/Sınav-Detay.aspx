<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sınav-Detay.aspx.cs" Inherits="deneme9.Sınav_Detay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.print.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/gasparesganga-jquery-loading-overlay@2.1.7/dist/loadingoverlay.min.js"></script>




    <link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/buttons/1.6.5/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
    <!-- Bootstrap 3.3.2 -->
    <link href="/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
          page. However, you can choose any other skin. Make sure you
          apply the skin class to the body tag so the changes take effect.
    -->
    <link href="/dist/css/skins/skin-blue.min.css" rel="stylesheet" type="text/css" />
    <link href="/dist/css/skins/skin-red.min.css" rel="stylesheet" />
    <link href="/dist/css/nprogress.css" rel="stylesheet" />
    <script src="/dist/js/nprogress.js"></script>
     <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jQuery-Knob/1.2.13/jquery.knob.min.js"></script>
    <style>
        .navbar {
            background-color: #39CCCC !important
        }

        .logo {
            background-color: #00AEAE !important
        }

        .box-header {
            background-color: #00DCDC !important
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            

            var countDownDate = new Date("2021/04/28 08:00:53").getTime(); //geri sayılacak ileri zamanki bir tarihi milisaniye cinsinden elde ediyoruz
            var Soru_Başı_Saniye = 0;

            $.ajax({
                url: 'Sınav-Detay.aspx/Soru_Suresi',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': ''}",
                async:false,
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
               
                    var temp = JSON.parse(data.d)
                    Soru_Başı_Saniye = parseInt(temp[0].Soru_Başı_Saniye)
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            var Sınav_Id = "";
            $.ajax({
                url: 'Sınav-Detay.aspx/Sınav_Tarihi',
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': ''}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var temp=JSON.parse(data.d)

                    var countDownDate_temp = new Date(temp[0].Sınav_Tar);
                    countDownDate = countDownDate_temp
                    Sınav_Id = temp[0].Sınav_Id;
                   

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            $(".dial").knob({
                max: Soru_Başı_Saniye,
                readOnly: true
            });

            var İnterval_Stop = false;


            var dayText = "Gün";
            var hourText = "Saat";
            var minuteText = "Dakika";
            var secondText = "Saniye";
            var Timer_Value = 0;
            if (countDownDate) { //tarih var ise
              
                var x = setInterval(function () { //sayacı belirli aralıklarla yenile

                    if (İnterval_Stop == false) {

                        

                        $.ajax({
                            url: 'Sınav-Detay.aspx/Sureyi_Getir',
                            dataType: 'json',
                            type: 'POST',
                            data: "{'Sınav_Id': '" + Sınav_Id + "'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {

                                var temp = JSON.parse(data.d)

                                countDownDate = new Date(temp[0].Sınav_Süresi).getTime();


                            },
                            error: function () {

                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        });

                        var now = new Date().getTime(); //şimdiki zamanı al
                        //geri sayılacak tarih ile şimdiki tarih arasındaki zaman farkını al
                        var distance = countDownDate - now;

                        if (distance < 0) { //zaman farkı yok ise belirtilen zamanı geçti
                            clearInterval(x); //sayacı sil
                            window.location.href = "/Sınav.aspx"
                        } else { //zaman farkı var ise
                            //aradaki zaman farkını gün,saat,dakika,saniye olarak böl
                            var days = Math.floor(distance / (1000 * 60 * 60 * 24)),
                                hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)),
                                minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60)),
                                seconds = Math.floor((distance % (1000 * 60)) / 1000),
                                hours = (hours ? '<span >' + hours + ':</span>' : '00:'), //saat varsa saat degerini yaz
                                minutes = (minutes ? '<span>' + minutes + ':</span>' : '00:'), //dakika varsa dakika degerini yaz
                                seconds = (seconds ? '<span>' + seconds + '</span>' : '00'); //saniye varsa saniye degerini yaz
                            document.getElementById("countdown_timer").innerHTML = hours + minutes + seconds; //yazdır
                            $(".dial").val(Math.floor((distance % (1000 * Soru_Başı_Saniye)) / 1000)).trigger('change');

                            if (Math.floor((distance % (1000 * Soru_Başı_Saniye)) / 1000) == 0) {
                                İnterval_Stop = true;

                                Swal.fire({
                                    icon: 'success',
                                    title: 'İşlem Sonucu',
                                    text: 'İşlem Başarılı',

                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        İnterval_Stop = false;
                                    }
                                })

                                var selected = $("input[name='optionsRadios']:checked").parent().attr('Sık_id')

                                if (selected == undefined) {
                                    selected = "0";
                                }

                                $.ajax({
                                    url: 'Sınav-Detay.aspx/Sonraki_Soru',
                                    dataType: 'json',
                                    type: 'POST',
                                    data: "{'parametre': '" + Sonraki_Soru.attr('simdiki_soru_id') + "-" + selected + "'}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {

                                        if (data.d == "2") {
                                            window.location.href = "/Sınav.aspx"
                                        }
                                        else {

                                            $.ajax({
                                                url: 'Sınav-Detay.aspx/Soru_Getir',
                                                dataType: 'json',
                                                type: 'POST',
                                                data: "{'parametre': ''}",
                                                contentType: 'application/json; charset=utf-8',
                                                success: function (data) {
                                                    var temp = JSON.parse(data.d)
                                                    console.log(temp)
                                                    Sonraki_Soru.removeAttr('Simdiki_Soru_Id')
                                                    Sonraki_Soru.removeAttr('Soru_Id')
                                                    Sonraki_Soru.attr('Simdiki_Soru_Id', temp[0].Simdiki_Soru_Id)
                                                    Sonraki_Soru.attr('Soru_Id', temp[0].Soru_Id)


                                                    Soru.empty();
                                                    Soru.append(temp[0].Soru)

                                                    Sık_1.empty();
                                                    Sık_1.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')

                                                    Sık_2.empty();
                                                    Sık_2.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')

                                                    Sık_3.empty();
                                                    Sık_3.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')

                                                    Sık_4.empty();
                                                    Sık_4.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')

                                                    Sık_5.empty();
                                                    Sık_5.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')


                                                    Sık_1.append(temp[0].Sık)
                                                    Sık_2.append(temp[1].Sık)
                                                    Sık_3.append(temp[2].Sık)
                                                    Sık_4.append(temp[3].Sık)
                                                    Sık_5.append(temp[4].Sık)


                                                    Sık_1.removeAttr('Sık_Id')
                                                    Sık_2.removeAttr('Sık_Id')
                                                    Sık_3.removeAttr('Sık_Id')
                                                    Sık_4.removeAttr('Sık_Id')
                                                    Sık_5.removeAttr('Sık_Id')
                                                    Sık_1.attr('Sık_Id', temp[0].Sık_Id)
                                                    Sık_2.attr('Sık_Id', temp[1].Sık_Id)
                                                    Sık_3.attr('Sık_Id', temp[2].Sık_Id)
                                                    Sık_4.attr('Sık_Id', temp[3].Sık_Id)
                                                    Sık_5.attr('Sık_Id', temp[4].Sık_Id)

                                                },
                                                error: function () {

                                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                                }
                                            });
                                        }




                                    },
                                    error: function () {

                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });
                                $.ajax({
                                    url: 'Sınav-Detay.aspx/Soru_Listesi',
                                    dataType: 'json',
                                    async: false,
                                    type: 'POST',
                                    data: "{'parametre': ''}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {

                                        Soru_Listesi.empty();
                                        var b = 0;
                                        while (data.d.split('!')[b] != null) {
                                            if (data.d.split('!')[b] == "0") {


                                                Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-question-circle"></i>' + (b + 1) + '.Soru</a></li>')

                                            }
                                            else {


                                                Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-check-square-o"></i>' + (b + 1) + '.Soru</a></li>')

                                            }
                                            b++;
                                        }

                                    },
                                    error: function () {

                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });
                            }
                        }
                    }
                    

                }, 1000); //1 saniyede bir sayaç güncellenecek
              

            }




            var Soru_Listesi = $('ul[id=Soru_Listesi]')
            var Soru = $('span[id=Soru]')
            var Sık_1 = $('label[id=Sık_1]')
            var Sık_2 = $('label[id=Sık_2]')
            var Sık_3 = $('label[id=Sık_3]')
            var Sık_4 = $('label[id=Sık_4]')
            var Sık_5 = $('label[id=Sık_5]')
            var Sonraki_Soru = $('button[id=Sonraki_Soru]')




            $.ajax({
                url: 'Sınav-Detay.aspx/Soru_Listesi',
                dataType: 'json',
                async: false,
                type: 'POST',
                data: "{'parametre': ''}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var b = 0;
                    while (data.d.split('!')[b] != null) {
                        if (data.d.split('!')[b] == "0") {
                            Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-question-circle"></i>' + (b + 1) + '.Soru</a></li>')
                        }
                        else {
                            Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-check-square-o"></i>' + (b + 1) + '.Soru</a></li>')
                        }
                        b++;
                    }

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });




            $.ajax({
                url: 'Sınav-Detay.aspx/Soru_Getir',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': ''}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var temp = JSON.parse(data.d)
                    console.log(temp)


                    Sonraki_Soru.attr('Simdiki_Soru_Id', temp[0].Simdiki_Soru_Id)
                    Sonraki_Soru.attr('Soru_Id', temp[0].Soru_Id)

                    Soru.append(temp[0].Soru)


                    Sık_1.append(temp[0].Sık)
                    Sık_2.append(temp[1].Sık)
                    Sık_3.append(temp[2].Sık)
                    Sık_4.append(temp[3].Sık)
                    Sık_5.append(temp[4].Sık)

                    Sık_1.attr('Sık_Id', temp[0].Sık_Id)
                    Sık_2.attr('Sık_Id', temp[1].Sık_Id)
                    Sık_3.attr('Sık_Id', temp[2].Sık_Id)
                    Sık_4.attr('Sık_Id', temp[3].Sık_Id)
                    Sık_5.attr('Sık_Id', temp[4].Sık_Id)


                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Sonraki_Soru.click(function () {

                İnterval_Stop = true;

               

                Swal.fire({
                    icon: 'success',
                    title: 'İşlem Sonucu',
                    text: 'İşlem Başarılı',

                }).then((result) => {
                    if (result.isConfirmed) {
                        İnterval_Stop = false;
                        $.ajax({
                            url: 'Sınav-Detay.aspx/Sureyi_Getir_Parametreli',
                            dataType: 'json',
                            type: 'POST',
                            data: "{'Sınav_Id': '" + Sınav_Id + "','Sure':'" + $('input[class=dial]').val() + "'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {

                                var temp = JSON.parse(data.d)
                               


                            },
                            error: function () {

                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        });
                    }
                })

                var selected = $("input[name='optionsRadios']:checked").parent().attr('Sık_id')

                if (selected == undefined) {
                    selected = "0";
                }

                $.ajax({
                    url: 'Sınav-Detay.aspx/Sonraki_Soru',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).attr('simdiki_soru_id') + "-" + selected + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        if (data.d == "2") {
                            window.location.href = "/Sınav.aspx"
                        }
                        else {

                            $.ajax({
                                url: 'Sınav-Detay.aspx/Soru_Getir',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': ''}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {
                                    var temp = JSON.parse(data.d)
                                    console.log(temp)

                                    Sonraki_Soru.removeAttr('Simdiki_Soru_Id')
                                    Sonraki_Soru.removeAttr('Soru_Id')
                                    Sonraki_Soru.attr('Simdiki_Soru_Id', temp[0].Simdiki_Soru_Id)
                                    Sonraki_Soru.attr('Soru_Id', temp[0].Soru_Id)


                                    Soru.empty();
                                    Soru.append(temp[0].Soru)

                                    Sık_1.empty();
                                    Sık_1.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')

                                    Sık_2.empty();
                                    Sık_2.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')

                                    Sık_3.empty();
                                    Sık_3.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')

                                    Sık_4.empty();
                                    Sık_4.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')

                                    Sık_5.empty();
                                    Sık_5.append('<input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">')


                                    Sık_1.append(temp[0].Sık)
                                    Sık_2.append(temp[1].Sık)
                                    Sık_3.append(temp[2].Sık)
                                    Sık_4.append(temp[3].Sık)
                                    Sık_5.append(temp[4].Sık)


                                    Sık_1.removeAttr('Sık_Id')
                                    Sık_2.removeAttr('Sık_Id')
                                    Sık_3.removeAttr('Sık_Id')
                                    Sık_4.removeAttr('Sık_Id')
                                    Sık_5.removeAttr('Sık_Id')
                                    Sık_1.attr('Sık_Id', temp[0].Sık_Id)
                                    Sık_2.attr('Sık_Id', temp[1].Sık_Id)
                                    Sık_3.attr('Sık_Id', temp[2].Sık_Id)
                                    Sık_4.attr('Sık_Id', temp[3].Sık_Id)
                                    Sık_5.attr('Sık_Id', temp[4].Sık_Id)


                                },
                                error: function () {

                                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                }
                            });
                        }




                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

                $.ajax({
                    url: 'Sınav-Detay.aspx/Soru_Listesi',
                    dataType: 'json',
                    async: false,
                    type: 'POST',
                    data: "{'parametre': ''}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Soru_Listesi.empty();
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            if (data.d.split('!')[b] == "0") {
                                Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-question-circle"></i>' + (b + 1) + '.Soru</a></li>')
                            }
                            else {
                                Soru_Listesi.append('<li class="treeview"><a><i class="fa fa-fw fa-check-square-o"></i>' + (b + 1) + '.Soru</a></li>')
                            }
                            b++;
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });


        });
    </script>
</head>
<body class=" skin-blue">

    <script>
        $('body').show();
        $('.version').text(NProgress.version);
        NProgress.start();
        setTimeout(function () { NProgress.done(); $('.fade').removeClass('out'); }, 1000);

        $("#b-0").click(function () { NProgress.start(); });
        $("#b-40").click(function () { NProgress.set(0.4); });
        $("#b-inc").click(function () { NProgress.inc(); });
        $("#b-100").click(function () { NProgress.done(); });
    </script>

    <form id="form1" runat="server">
        <div class="wrapper">
            <!-- Main Header -->
            <header class="main-header">
                <!-- Logo -->
                <a class="logo"><b>EDİS</b>PHARMA</a>
                <!-- Header Navbar -->
                <nav class="navbar navbar-static-top" role="navigation">
                    <!-- Sidebar toggle button-->
                    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                        <span class="sr-only">Toggle navigation</span>
                    </a>
                    <!-- Navbar Right Menu -->
                    <div class="navbar-custom-menu">
                    </div>

                </nav>
            </header>
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="main-sidebar">

                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <ul id="Soru_Listesi" class="sidebar-menu">
                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>
            <!-- Content Wrapper. Contains page content -->

            <div class="content-wrapper">
                <section id="content" class="content">

                    <section class="panel">

                        <h2 id="countdown_timer" class="text-center">
                            <span class="label label-danger label-sm text-normal va-middle mr-sm"></span>


                        </h2>
                        <h2></h2>


                    </section>
                    <div class="row">


                        <div class="col-xs-8">
                            <section class="panel">
                                <header class="panel-heading">
                                    <h2 class="panel-title">
                                        <span class="label label-danger label-sm text-normal va-middle mr-sm" id="BekleyenSinavSayisi"></span>
                                        <span style="font-size: 20px; font-weight: bold;" class="va-middle" id="Soru"></span>
                                    </h2>
                                </header>
                                <div id="Sınav_Listesi" class="panel-body">

                                    <div id="Radio_Div" class="form-group">
                                        <div class="radio">
                                            <label id="Sık_1">
                                                <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" />

                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label id="Sık_2">
                                                <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2" />

                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label id="Sık_3">
                                                <input type="radio" name="optionsRadios" id="optionsRadios3" value="option3" />

                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label id="Sık_4">
                                                <input type="radio" name="optionsRadios" id="optionsRadios4" value="option4" />

                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label id="Sık_5">
                                                <input type="radio" name="optionsRadios" id="optionsRadios5" value="option5" />

                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <button type="button" id="Sonraki_Soru" class="btn btn-block btn-info btn-lg">Sonraki Soru</button>
                                    </div>
                                </div>

                            </section>

                        </div>
                        <div class="col-xs-4 text-center">
                            <input type="text" value="0" class="dial" />
                        </div>
                    </div>





                </section>
            </div>
            <!-- /.content-wrapper -->

            <!-- Main Footer -->
            <footer class="main-footer">
                <!-- To the right -->

                <!-- Default to the left -->
                <strong>Copyright &copy; 2021 Company.</strong> Tüm Hakları Saklıdır.
            </footer>
        </div>
        <!-- jQuery 2.1.3 -->

        <!-- Bootstrap 3.3.2 JS -->
        <script src="/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- AdminLTE App -->
        <script src="/dist/js/app.min.js" type="text/javascript"></script>

    </form>
</body>
</html>
