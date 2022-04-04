<%@ Page Title="" Language="C#" MasterPageFile="~/Bs.Master" AutoEventWireup="true" CodeBehind="Tsm-Koçluk-Formu-Rapor.aspx.cs" Inherits="deneme9.Tsm_Koçluk_Formu_Rapor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/venobox/1.9.3/venobox.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/venobox/1.9.3/venobox.min.css" />

    <script type="text/javascript">
        $(document).ready(function () {
            var TextBox2 = $('input[id*=TextBox2]')
            var TextBox3 = $('input[id*=TextBox3]')

            var Today = new Date();

            function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + (d.getDate()),
                    year = d.getFullYear();

                if (month.length < 2)
                    month = '0' + month;
                if (day.length < 2)
                    day = '0' + day;

                return [year, month, day].join('-');
            }

            var x = new Date(Today);

            var d = new Date(x.getFullYear(), x.getMonth() + 1, 0);
            TextBox3.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), x.getMonth(), 1);
            TextBox2.attr('value', formatDate(d));

            var Tsm_Ad = $('select[id=Tsm_Ad]')


            $.ajax({
                url: 'Tsm-Plan-Raporu.aspx/Kullanıcı_Listesi',
                type: 'POST',
                data: "{'Şehir_Id': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var parsdata = JSON.parse(data.d)

                    Tsm_Ad.empty();
                    Tsm_Ad.append('<option value="0">Lütfen TSM Seçiniz</option>')
                    for (var i = 0; i < parsdata.length; i++) {
                        Tsm_Ad.append('<option value="' + parsdata[i].Kullanıcı_ID + '">' + parsdata[i].Ad + ' ' + parsdata[i].Soyad + '</option>')
                    }


                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });

            if (window.location.href.split('&').length > 1) {
                var Gün_Div = $('div[id=Gün_Div]')
                Gün_Div.attr('style', "visibility:visible")
                Tsm_Ad.val(window.location.href.split('&')[2].split('=')[1])
                TextBox2.val(window.location.href.split('&')[0].split('=')[1])
                TextBox3.val(window.location.href.split('&')[1].split('=')[1])
            }

            else {
                var Gün_Div = $('div[id=Gün_Div]')
                Gün_Div.attr('style', "visibility:hidden")
            }

            Tsm_Ad.change(function () {//Dktr_Brans.parent().children().find($("select option:first-child"))
                if (Tsm_Ad.parent().children().find($("select option:first-child")).val() == "0") {
                    Tsm_Ad.parent().children().find($("select option:first-child")).remove();
                }

            })
            var cal_set = $('input[id=cal_set]')
            cal_set.on('click', function () {
                if (Tsm_Ad.find('option:selected').val() != 0) {
                    window.location.href = "Tsm-Koçluk-Formu-Rapor.aspx?x=" + TextBox2.val() + "&y=" + TextBox3.val() + "&z=" + Tsm_Ad.find('option:selected').val()
                }
                else {
                    alert("Lütfen TSM Seçiniz")
                }
            });
            var Bas_Gun = TextBox2.val();
            var Son_Gun = TextBox3.val();
            var Kullanıcı = window.location.href.split('&')[2].split('=')[1];
            var Kullanıcı_Ad = Tsm_Ad.find('option:selected').html()

            var parsdata;
            $.ajax({
                url: 'Tsm-Koçluk-Formu-Rapor.aspx/Tabloları_Doldur',
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '" + TextBox2.val() + "*" + TextBox3.val() + "*" + Kullanıcı + "'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var temp = JSON.parse(data.d)

                    parsdata = temp;
                    console.log(temp)
                    for (var i = 0; i < temp.length; i++) {

                        var lookup = {};
                        var items = temp[i];
                        var result = [];

                        for (var item, j = 0; item = items[j++];) {
                            var name = item.Koçluk_Formu_Genel_Id;

                            if (!(name in lookup)) {
                                lookup[name] = 1;
                                result.push(item);
                            }
                        }


                        var bi_kere_Yaz = 0;
                        if (bi_kere_Yaz==0) {
                            console.log(result)
                            bi_kere_Yaz++;
                        }
                        

                        for (var k = 0; k < result.length; k++) {
                            var cins = result[k].Koçluk_Formu_Soru_Cins_İd

                            var Soru_İçeriği__ = "";
                            if (cins == "1") {

                                var groupBy = function (xs, key) {
                                    return xs.reduce(function (rv, x) {
                                        (rv[x[key]] = rv[x[key]] || []).push(x);
                                        return rv;
                                    }, {});
                                };
                                var groubedByTeam = groupBy(temp[i], 'Koçluk_Formu_Genel_Id');
                                console.log(groubedByTeam)


                                var Resimler = "";
                                for (var j = 0; j < groubedByTeam[result[k].Koçluk_Formu_Genel_Id].length; j++) {
                                    console.log(groubedByTeam[result[k].Koçluk_Formu_Genel_Id][j].Koçluk_Formu_Genel_Id)
                                    var Resim_kendisi =
                                        '                                                                <div id="Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Zone_Silmek_için_1_0" class="preview-image">' +
                                        '                                                                    <div class="image-zone">' +
                                        '                                                                        <a class="venobox" href="' + groubedByTeam[result[k].Koçluk_Formu_Genel_Id][j].Resim + '">' +
                                        '                                                                            <img style="width:100%" id="Resimli_Soru" src="' + groubedByTeam[result[k].Koçluk_Formu_Genel_Id][j].Resim + '"></a>' +
                                        '                                                                    </div>' +
                                        '                                                                    </div>';
                                    Resimler += Resim_kendisi;
                                }
                                var Resim_Zone =

                                    '                                            <div class="row">' +
                                    '                                                <div class="col-xs-12">' +
                                    '                                                    <div id="Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim1">' +
                                    '                                                        <div class="col-xs-12">' +
                                    '                                                            <div class="preview-images-zone" id="Şirket_Değerleriyle_Uyumlu_Genel_Görünüm_Resim_Zone_1" style="">' + Resimler +
            
   
                                    '                                                                </div>' +
                                    '                                                            </div>' +
                                    '                                                        </div>' +
                                    '                                                    </div>' +
                                    '                                                </div>';
                                Soru_İçeriği__ = Resim_Zone;

                                var Puan_span = "";
                                if (result[k].Soru_Puan == "1") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-danger">Zayıf</span>';
                                }
                                if (result[k].Soru_Puan == "2") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-warning">Gelişmeli</span>';
                                }
                                if (result[k].Soru_Puan == "3") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-primary">Orta</span>';
                                }
                                if (result[k].Soru_Puan == "4") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-info">İyi</span>';
                                }
                                if (result[k].Soru_Puan == "5") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-success">Çok İyi</span>';
                                }

                                var Buraya_Ekleyecen = $('div[id=Buraya_Ekleyecen_' + result[k].Koçluk_Formu_Genel_Id + ']')
                                var myvar = '<div style="padding-top:30px" class="box"></div>' +
                                    '<div  class="box-body" >' +
                                    '                                            <div class="row">' +
                                    '                                                <div class="col-xs-6 text-center">' +
                                    '                                                    <label style="font-size:20px">' + result[k].Soru_Text_Kendisi + '</label>' +
                                    '                                                </div>' +
                                    '                                                <div class="col-xs-6 text-center">' + Puan_span +

                                    '                                                </div>' +
                                    '                                            </div>' +
                                    '                                        </div>' +
                                    '                                        <div class="box-footer" id="Soru_İçeriği" Soru_Cins="' + result[k].Koçluk_Formu_Soru_Cins_İd + '">' + Soru_İçeriği__ + '</div>';


                                Buraya_Ekleyecen.append(myvar)


                            }
                            if (cins == "3") {
                                var Soru_İçeriği_ = '<div class="form-group">' +
                               
                                    '                  <textarea class="form-control" rows="3" placeholder="Enter ..." disabled="">' + result[k].Soru_Text_Not+'</textarea>' +
                                    '</div>';
                                var Buraya_Ekleyecen = $('div[id=Buraya_Ekleyecen_' + result[k].Koçluk_Formu_Genel_Id + ']')
                                var myvar = '<div style="padding-top:30px" class="box"></div>' +
                                    '<div  class="box-body" >' +
                                    '                                            <div class="row">' +
                                    '                                                <div class="col-xs-6 text-center">' +
                                    '                                                    <label style="font-size:20px">' + result[k].Soru_Text_Kendisi + '</label>' +
                                    '                                                </div>' +
                                    '                                                <div class="col-xs-6 text-center">' + Soru_İçeriği_ +

                                    '                                                </div>' +
                                    '                                            </div>' +
                                    '                                        </div>' +
                                    '                                        <div class="box-footer" id="Soru_İçeriği" Soru_Cins="' + result[k].Koçluk_Formu_Soru_Cins_İd + '">' + Soru_İçeriği__ + '</div>';


                                Buraya_Ekleyecen.append(myvar)
                            }
                            if (cins == "2") {
                                var Puan_span = "";
                                if (result[k].Soru_Puan == "1") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-danger">Zayıf</span>';
                                }
                                if (result[k].Soru_Puan == "2") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-warning">Gelişmeli</span>';
                                }
                                if (result[k].Soru_Puan == "3") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-primary">Orta</span>';
                                }
                                if (result[k].Soru_Puan == "4") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-info">İyi</span>';
                                }
                                if (result[k].Soru_Puan == "5") {
                                    Puan_span = '<span  style="font-size:25px" class="text-center label label-success">Çok İyi</span>';
                                }

                                var Buraya_Ekleyecen = $('div[id=Buraya_Ekleyecen_' + result[k].Koçluk_Formu_Genel_Id + ']')
                                var myvar = '<div style="padding-top:30px" class="box"></div>' +
                                    '<div  class="box-body" >' +
                                    '                                            <div class="row">' +
                                    '                                                <div class="col-xs-6 text-center">' +
                                    '                                                    <label style="font-size:20px">' + result[k].Soru_Text_Kendisi + '</label>' +
                                    '                                                </div>' +
                                    '                                                <div class="col-xs-6 text-center">' + Puan_span +

                                    '                                                </div>' +
                                    '                                            </div>' +
                                    '                                        </div>' +
                                    '                                        <div class="box-footer" id="Soru_İçeriği" Soru_Cins="' + result[k].Koçluk_Formu_Soru_Cins_İd + '">' + Soru_İçeriği__ + '</div>';


                                Buraya_Ekleyecen.append(myvar)
                            }
                           

                        }





                        

                     

                    }





                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            $('.venobox').venobox();


        });

    </script>

    <style>
        .preview-images-zone {
            width: 100%;
            border: 1px solid #ddd;
            min-height: 180px;
            display: flex;
            padding: 5px 5px 0px 5px;
            position: relative;
            overflow: auto;
        }

            .preview-images-zone > .preview-image:first-child {
                height: 15%;
                width: 15%;
                position: relative;
                margin-right: 5px;
            }

            .preview-images-zone > .preview-image {
                height: 15%;
                width: 15%;
                position: relative;
                margin-right: 5px;
                float: left;
                margin-bottom: 5px;
            }

                .preview-images-zone > .preview-image > .image-zone {
                    width: 100%;
                    height: 100%;
                }

                    .preview-images-zone > .preview-image > .image-zone > img {
                        width: 100%;
                        height: 100%;
                    }

                .preview-images-zone > .preview-image > .tools-edit-image {
                    position: absolute;
                    z-index: 100;
                    color: #fff;
                    bottom: 0;
                    width: 100%;
                    text-align: center;
                    margin-bottom: 10px;
                    display: none;
                }

                .preview-images-zone > .preview-image > .image-cancel {
                    font-size: 18px;
                    position: absolute;
                    top: 0;
                    right: 0;
                    font-weight: bold;
                    margin-right: 10px;
                    cursor: pointer;
                    display: none;
                    z-index: 100;
                }

        .preview-image:hover > .image-zone {
            cursor: move;
            opacity: .5;
        }

        .preview-image:hover > .tools-edit-image,
        .preview-image:hover > .image-cancel {
            display: block;
        }

        .ui-sortable-helper {
            width: 90px !important;
            height: 90px !important;
        }
    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="box">
        <div class="box-body">
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <%--// has-error--%>
                        <label>TSM Adı</label>
                        <select id="Tsm_Ad" class="form-control">
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-5 ">
                    <div class="form-group">
                        <asp:TextBox ID="TextBox2" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="col-xs-5 ">
                    <div class="form-group">
                        <asp:TextBox ID="TextBox3" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-2 ">
                        <div class="form-group">
                            <input id="cal_set" type="button" class="btn btn-block btn-info" value="SET" />
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>
    <div class="box" id="Gün_Div" style="visibility: hidden">
        <div class="box-body" id="Günler">
            <div class="row">

                
            </div>
            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>



                    <div class="row">
                        <div class="col-lg-12">
                            <div class="box box-default box-solid collapsed-box">
                                <div class="box-header with-border  bg-blue-gradient">

                                    <div class="col-xs-2">
                                    <span id="gun" class="col-xs-1" style="font-size: 50px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:%d}") %></span>
                                     </div>
                                    <div class="col-xs-1">
                                    <span id="ay_yıl" class="col-xs-1" style="font-size: 22px; color: #1e1b1b"><%#Eval("Ziy_Tar","{0:% MMMM}") %></br><%#Eval("Ziy_Tar","{0:% yyyy}") %></span>
                                     </div>
                                     <div class="col-xs-1">
                                    <span class="col-xs-3" style="font-size: 12px;"></span>
                                     </div>
                                    <span id="Header_Sayac_span_<%#Eval("Ziy_Tar","{0:%d}") %>" class="col-xs-3" style="font-size: 19px;">Toplam Puan: <span class="label label-warning"><%#Eval("Toplam_Puan") %></span> </br>Toplam Puan (100 Üzerinden):<span class="label label-warning"> <%#Eval("Toplam_Puan_Yüzde") %></span> </span>
                                    <span id="Gun_txt_1" class="col-xs-1" style="font-size: 20px"><%#Eval("Ziy_Tar","{0:% dddddd}") %></span>

                                    <div class="box-tools ">

                                        <button type="button" class=" btn-primary no-border bg-blue-gradient" data-widget="collapse" style="font-size: 50px">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <!-- /.box-tools -->
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body" style="display: none;" id="Sipariş_Div_<%#Eval("Koçluk_Formu_Genel_Id") %>">
                                    <div class="box" id="Buraya_Ekleyecen_<%#Eval("Koçluk_Formu_Genel_Id") %>">
                                        
                                           
                                          
                                        </div>
                                </div>
                              


                            </div>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>






</asp:Content>
