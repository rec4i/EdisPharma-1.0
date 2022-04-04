<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Sınav.aspx.cs" Inherits="deneme9.Sınav" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            function dateAdd(date, interval, units) {
                if (!(date instanceof Date))
                    return undefined;
                var ret = new Date(date); //don't change original date
                var checkRollover = function () { if (ret.getDate() != date.getDate()) ret.setDate(0); };
                switch (String(interval).toLowerCase()) {
                    case 'year': ret.setFullYear(ret.getFullYear() + units); checkRollover(); break;
                    case 'quarter': ret.setMonth(ret.getMonth() + 3 * units); checkRollover(); break;
                    case 'month': ret.setMonth(ret.getMonth() + units); checkRollover(); break;
                    case 'week': ret.setDate(ret.getDate() + 7 * units); break;
                    case 'day': ret.setDate(ret.getDate() + units); break;
                    case 'hour': ret.setTime(ret.getTime() + units * 3600000); break;
                    case 'minute': ret.setTime(ret.getTime() + units * 60000); break;
                    case 'second': ret.setTime(ret.getTime() + units * 1000); break;
                    default: ret = undefined; break;
                }
                return ret;
            }

            $.ajax({
                url: 'Sınav.aspx/Sınav_Listesi',
                dataType: 'json',
                type: 'POST',

                data: "{'parametre': '" + "asd" + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var Sınav_Listesi = $('div[id=Sınav_Listesi]')
                    var b = 1;
                    while (data.d.split('!')[b] != null) {


                        c = new Date(data.d.split('!')[b].split('/')[4])
                        y = new Date(data.d.split('!')[0]);
                        var x = dateAdd(c, 'minute', parseInt(data.d.split('!')[b].split('/')[5]));
                        var button_Back = ""





                        if (new Date(y) <= new Date(x)) {
                            if (new Date(y) > new Date(c)) {
                                button_Back = "style='background-color:yellow'"
                            }
                        }
                        else {
                            button_Back = "";
                        }
                        Sınav_Listesi.append('<div class="alert alert-success alert-dismissible">' +
                            ' <div class="row">' +

                            ' <div class="col-xs-2 ">' +
                            '  <button ' + button_Back + ' type="button" class="btn btn-app" id="Sınava_Gir" Sınav_Id="' + data.d.split('!')[b].split('/')[1] + '" value="' + data.d.split('!')[b].split('/')[0] + '" aria-hidden="true"><i class="fa fa-play"></i>Başla</button>' +
                            ' </div>' +
                            ' <div class="col-xs-4 ">' +

                            '<div class="row">' +
                            '  <span>Sınav Tarihi: ' + data.d.split('!')[b].split('/')[4] + '</span>' +
                            '</div>' +
                            ' <div class="row">' +
                            ' <span>Sınav Süresi: ' + data.d.split('!')[b].split('/')[5] + '</span>' +
                            ' </div>' +
                            ' <div class="row">' +
                            ' <span>Sınav Adı: ' + data.d.split('!')[b].split('/')[6] + '</span>' +
                            '  </div>' +
                            '   </div>' +

                            '</div>' +
                            '  </div>')

                        b++;
                    }
                    var Sınava_Gir = $('button[id*=Sınava_Gir]');
                    Sınava_Gir.click(function () {

                        var a = $(this).attr('value');
                        $.ajax({
                            url: 'Sınav.aspx/Sınavı_Başlat',
                            dataType: 'json',
                            type: 'POST',
                            global:false,
                            data: "{'parametre': '" + a + "'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                if (data.d == "0") {
                                    alert("Sınav Henüz Başlamadı")
                                }
                                if (data.d == "2") {
                                   // 
                                    let timerInterval
                                    Swal.fire({
                                        title: 'Sınav Başlatılıyor',
                                        html: 'Sınava Yönlendiliyorsunuz <b></b> .',
                                        timer: 2000,
                                        timerProgressBar: true,
                                        didOpen: () => {
                                            Swal.showLoading()
                                            timerInterval = setInterval(() => {
                                                const content = Swal.getHtmlContainer()
                                                if (content) {
                                                    const b = content.querySelector('b')
                                                    if (b) {
                                                        b.textContent = Swal.getTimerLeft()
                                                    }
                                                }
                                            }, 100)
                                            
                                        },
                                        willClose: () => {
                                            clearInterval(timerInterval)
                                       
                                            window.location.href = "/Sınav-Detay.aspx"
                                        }
                                    }).then((result) => {
                                        /* Read more about handling dismissals below */
                                        if (result.dismiss === Swal.DismissReason.timer) {
                                       
                                        }
                                    })
                                }
                            },
                            error: function () {

                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        });
                    });

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            var Sınav_Tar = [];
            var Sınav_Not = [];
           
            $.ajax({
                url: 'Sınav.aspx/Sınav_Grafik',
                type: 'POST',
                data: "{'Sınav_Id': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var temp = JSON.parse(data.d)

                    for (var i = 0; i < temp.length; i++) {
                        Sınav_Tar.push(temp[i].Sınav_Tar)
                        Sınav_Not.push(parseInt(temp[i].Sınav_Not))
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            var ctx = $('canvas[id=Bu_Deneme]');
  
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: Sınav_Tar,
                    datasets: [{
                        fill: false,
                        height: 10,
                        width: 10,
                        data: Sınav_Not,
                        backgroundColor: [
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',
                            'rgba(26, 213, 255, 0.2)',


                        ],
                        borderColor: [
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',
                            'rgba(26, 213, 255, 1)',

                        ],
                        borderWidth: 2
                    }]
                },
                options: {
                    legend: {
                        display: false
                    },
                    tooltips: {
                        callbacks: {
                            label: function (tooltipItem) {
                                return tooltipItem.yLabel;
                            }
                        }
                    },

                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true,
                                //callback: function (value, index, values) {
                                //    return value + '₺';
                                //}

                            }
                        }]
                    }
                }
            });

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="Mesaj" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">İşlem Sonucu</h4>
                </div>
                <div class="modal-body">
                    <p id="Mesaj_Detay"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <section class="panel">
        <header class="panel-heading">
            <h2 class="panel-title">
                <span class="label label-danger label-sm text-normal va-middle mr-sm" id="BekleyenSinavSayisi"></span>
                <span class="va-middle">Bekleyen Sınavlar</span>
            </h2>
        </header>
        <div id="Sınav_Listesi" class="panel-body">
        </div>
    </section>
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-header with-border">
                    <i class="fa fa-bar-chart-o"></i>
                    <h3 class="box-title">Son 30 Sınav Notun</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                            <i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="card">
                        <div class="card-body">
                            <canvas id="Bu_Deneme"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
