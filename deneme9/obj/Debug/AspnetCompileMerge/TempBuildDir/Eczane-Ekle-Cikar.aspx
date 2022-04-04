<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Eczane-Ekle-Cikar.aspx.cs" Inherits="deneme9.Eczane_Ekle_Cikar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            var Eczane_Ekle_Çıkar_Ekle_il = $('select[id=Eczane_Ekle_Çıkar_Ekle_il]')//Eczane_Ekle_Çıkar_Ekle_Brick
            var Eczane_Ekle_Çıkar_Ekle_Brick = $('select[id=Eczane_Ekle_Çıkar_Ekle_Brick]')//Eczane_Ekle_Çıkar_Ekle_Ad//Eczane_Ekle_Çıkar_Ekle_Button//Eczane_Ekle_Çıkar_Ekle_Telefon
            var Eczane_Ekle_Çıkar_Ekle_Ad = $('input[id=Eczane_Ekle_Çıkar_Ekle_Ad]')
            var Eczane_Ekle_Çıkar_Ekle_Button = $('a[id=Eczane_Ekle_Çıkar_Ekle_Button]')//Eczane_Ekle_Çıkar_Çıkar_Adres//Eczane_Ekle_Çıkar_Çıkar_Adres//Eczane_Ekle_Çıkar_Çıkar_Eczaneler//Eczane_Ekle_Çıkar_Çıkar_Brick
            var Eczane_Ekle_Çıkar_Ekle_Telefon = $('input[id=Eczane_Ekle_Çıkar_Ekle_Telefon]')//Eczane_Ekle_Çıkar_Çıkar_Il
            var Eczane_Ekle_Çıkar_Ekle_Adres = $('textarea[id=Eczane_Ekle_Çıkar_Ekle_Adres]')//Eczane_Ekle_Çıkar_Duzenle_Button



            var Eczane_Ekle_Çıkar_Çıkar_Il = $('select[id=Eczane_Ekle_Çıkar_Çıkar_Il]')//Eczane_Ekle_Çıkar_Çıkar_Button
            var Eczane_Ekle_Çıkar_Çıkar_Adres = $('textarea[id=Eczane_Ekle_Çıkar_Çıkar_Adres]')
            var Eczane_Ekle_Çıkar_Çıkar_Eczaneler = $('select[id=Eczane_Ekle_Çıkar_Çıkar_Eczaneler]')
            var Eczane_Ekle_Çıkar_Çıkar_Brick = $('select[id=Eczane_Ekle_Çıkar_Çıkar_Brick]')
            var Eczane_Ekle_Çıkar_Çıkar_Telefon = $('input[id=Eczane_Ekle_Çıkar_Çıkar_Telefon]')
            var Eczane_Ekle_Çıkar_Çıkar_Button = $('a[id=Eczane_Ekle_Çıkar_Çıkar_Button]')


            $.ajax({
                url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Eczane_Ekle_Çıkar_Çıkar_Il.empty();
                    Eczane_Ekle_Çıkar_Çıkar_Il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")
                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Eczane_Ekle_Çıkar_Çıkar_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Eczane_Ekle_Çıkar_Çıkar_Il.change(function () {
                Eczane_Ekle_Çıkar_Çıkar_Il.parent().removeAttr("class");
                Eczane_Ekle_Çıkar_Çıkar_Il.parent().attr("class", "form-group");
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Çıkar_Çıkar_Brick.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Çıkar_Çıkar_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Eczane_Ekle_Çıkar_Çıkar_Il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Çıkar_Çıkar_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
                // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            })


            Eczane_Ekle_Çıkar_Çıkar_Brick.change(function () {


                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/Eczane_Listele',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).val() + "-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Çıkar_Çıkar_Adres.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Telefon.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Eczaneler.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Eczaneler.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Çıkar_Çıkar_Eczaneler.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                         
                            b++;
                        }
                        if (Eczane_Ekle_Çıkar_Çıkar_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Çıkar_Çıkar_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            });
            Eczane_Ekle_Çıkar_Çıkar_Eczaneler.change(function () {

                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/Eczane_Listele_detay',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).val() + "-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                      
                        Eczane_Ekle_Çıkar_Çıkar_Adres.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Telefon.empty();
                        
                        
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Çıkar_Çıkar_Adres.val(data.d.split('!')[b].split("-")[2])
                            Eczane_Ekle_Çıkar_Çıkar_Telefon.val(data.d.split('!')[b].split("-")[3])
                            b++;
                        }
                        if (Eczane_Ekle_Çıkar_Çıkar_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Çıkar_Çıkar_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });//Eczane_Çıkar_Button


            });
            Eczane_Ekle_Çıkar_Çıkar_Button.click(function () {

                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/Eczane_Çıkar_Button',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Eczane_Ekle_Çıkar_Çıkar_Eczaneler.find('option:selected').val() + "-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                       
                        Eczane_Ekle_Çıkar_Çıkar_Adres.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Telefon.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Eczaneler.empty();
                        Eczane_Ekle_Çıkar_Çıkar_Brick.empty();
                        if (data.d == "1") {
                            alert("İşlem Başarılı")
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });//Eczane_Çıkar_Button

            });



            Eczane_Ekle_Çıkar_Duzenle_Button.click(function () {//Zamanlı_Giriş_Deneme


            });

            function Il_Listele() {
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '0-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Çıkar_Ekle_il.empty();
                        Eczane_Ekle_Çıkar_Ekle_il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Eczane_Ekle_Çıkar_Ekle_il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;

                        }

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            }
            $.ajax({
                url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Eczane_Ekle_Çıkar_Ekle_il.empty();
                    Eczane_Ekle_Çıkar_Ekle_il.append("<option>-->> Lütfen Şehir Seçiniz <<--</option>")
                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Eczane_Ekle_Çıkar_Ekle_il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });

            Eczane_Ekle_Çıkar_Ekle_il.change(function () {
                Eczane_Ekle_Çıkar_Ekle_il.parent().removeAttr("class");
                Eczane_Ekle_Çıkar_Ekle_il.parent().attr("class", "form-group");
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Ekle_Çıkar_Ekle_Brick.empty();
                        Eczane_Ekle_Çıkar_Ekle_Brick.append("<option>-->> Lütfen Brick Seçiniz <<--</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Ekle_Çıkar_Ekle_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Eczane_Ekle_Çıkar_Ekle_il.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Ekle_Çıkar_Ekle_il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
                // tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
            })

            Eczane_Ekle_Çıkar_Ekle_Button.click(function () {
                $.ajax({
                    url: 'Eczane-Ekle-Cikar.aspx/Eczane_Ekle',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Eczane_Ekle_Çıkar_Ekle_Ad.val() + "-" + Eczane_Ekle_Çıkar_Ekle_Brick.val() + "-" + Eczane_Ekle_Çıkar_Ekle_il.val() + "-" + Eczane_Ekle_Çıkar_Ekle_Adres.val() + "-" + Eczane_Ekle_Çıkar_Ekle_Telefon.val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var Eczane_Ekle_Çıkar_Ekle_il = $('select[id=Eczane_Ekle_Çıkar_Ekle_il]')//Eczane_Ekle_Çıkar_Ekle_Brick
                        var Eczane_Ekle_Çıkar_Ekle_Brick = $('select[id=Eczane_Ekle_Çıkar_Ekle_Brick]')//Eczane_Ekle_Çıkar_Ekle_Ad//Eczane_Ekle_Çıkar_Ekle_Button//Eczane_Ekle_Çıkar_Ekle_Telefon
                        var Eczane_Ekle_Çıkar_Ekle_Ad = $('input[id=Eczane_Ekle_Çıkar_Ekle_Ad]')

                        var Eczane_Ekle_Çıkar_Ekle_Telefon = $('input[id=Eczane_Ekle_Çıkar_Ekle_Telefon]')
                        var Eczane_Ekle_Çıkar_Ekle_Adres = $('textarea[id=Eczane_Ekle_Çıkar_Ekle_Adres]')

                        Eczane_Ekle_Çıkar_Ekle_Ad.val().empty();
                        Eczane_Ekle_Çıkar_Ekle_Adres.val().empty();
                        Eczane_Ekle_Çıkar_Ekle_il.empty();
                        Eczane_Ekle_Çıkar_Ekle_Brick.empty();
                        Eczane_Ekle_Çıkar_Ekle_Telefon.val().empty();
                        Il_Listele();
                        alert("İşlem Başarılı")

                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });




        });


    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#tab_1" data-toggle="tab" aria-expanded="true">Eczane Düzenle
                        </a>
                    </li>
                    <li class=""><a href="#tab_2" data-toggle="tab" aria-expanded="false">Eczane Çıkar</a></li>
                    <li class=""><a href="#tab_3" data-toggle="tab" aria-expanded="false">Eczane Ekle</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab_1">


                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İL Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Brick Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Telefon</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input type="text" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Adres</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <textarea class="form-control" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Eczane_Ekle_Çıkar_Duzenle_Button" class="btn btn-info pull-right">Seçilen Eczaneyi Düzenle</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab_2">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İL Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Eczane_Ekle_Çıkar_Çıkar_Il" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Brick Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Eczane_Ekle_Çıkar_Çıkar_Brick" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Eczane_Ekle_Çıkar_Çıkar_Eczaneler" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Telefon</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Eczane_Ekle_Çıkar_Çıkar_Telefon" type="text" class="form-control" disabled="">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Adres</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <textarea id="Eczane_Ekle_Çıkar_Çıkar_Adres" class="form-control" rows="3" disabled=""></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Eczane_Ekle_Çıkar_Çıkar_Button" class="btn btn-info pull-right">Seçilen Eczaneyi Çıkar</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab_3">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İL Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Eczane_Ekle_Çıkar_Ekle_il" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Brick Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Eczane_Ekle_Çıkar_Ekle_Brick" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Eczane Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Eczane_Ekle_Çıkar_Ekle_Ad" type="text" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Telefon</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Eczane_Ekle_Çıkar_Ekle_Telefon" type="text" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Adres</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <textarea id="Eczane_Ekle_Çıkar_Ekle_Adres" class="form-control" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Eczane_Ekle_Çıkar_Ekle_Button" class="btn btn-info pull-right">Eczaneyi Ekle</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

