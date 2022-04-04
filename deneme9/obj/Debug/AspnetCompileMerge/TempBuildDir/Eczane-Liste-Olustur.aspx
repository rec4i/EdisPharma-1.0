<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Eczane-Liste-Olustur.aspx.cs" Inherits="deneme9.Eczane_Liste_Olustur" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script type="text/javascript">

        $(document).ready(function () {
            var Eczane_Yeni_Liste_Olustur_Modal_btn = $('button[id=Eczane_Yeni_Liste_Olustur_Modal_btn]'); //doktorları listelerken tersten listele 
            var Eczane_Liste_Olustur_Liste = $('select[id=Eczane_Liste_Olustur_Liste]');
            var Eczane_Yeni_Liste_Input = $('input[id=Eczane_Yeni_Liste_Input]');
            var Eczane_Listesi_Tablosu = $('table[id=Eczane_Listesi_Tablosu]');
            var Eczane_Liste_Ekle_btn = $('a[id=Eczane_Liste_Ekle_btn]') //doktorları listelerken tersten listele 
            var Eczane_Liste_Il = $('select[id=Eczane_Liste_Il]');
            Eczane_Liste_Il.append("<option>Lütfen İl Seçiniz</option>");
            var Eczane_Liste_Brick = $('select[id=Eczane_Liste_Brick]');
            var Eczane_Liste_Eczane = $('select[id=Eczane_Liste_Eczane]');
            var Eczane_Liste_Frekans = $('select[id=Eczane_Liste_Frekans]');
            var tablo_kontrol = true;



            //doktorları listelerken tersten listele 
            Eczane_Liste_Olustur_Liste.empty()

            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {


                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Eczane_Liste_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Eczane_Liste_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Eczane_Liste_Brick.empty();
                        Eczane_Liste_Brick.append("<option>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Liste_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Eczane_Liste_Il.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Eczane_Liste_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Eczane_Liste_Brick.change(function () {
                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Eczane_Listele',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).val() + "-0'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Eczane_Liste_Eczane.empty();
                        Eczane_Liste_Eczane.append("<option>Lütfen Eczane Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Eczane_Liste_Eczane.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");

                            b++;
                        }
                        if (Eczane_Liste_Brick.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Eczane_Liste_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            });

            Eczane_Liste_Eczane.change(function () {
          
                Eczane_Liste_Frekans.empty();
                Eczane_Liste_Frekans.append("<option>Lütfen Frekans Seçiniz</option>");
                Eczane_Liste_Frekans.append("<option value='2'>A  (Ayda 2 Kere Ziyaret)</option>");
                Eczane_Liste_Frekans.append("<option value='4'>B  (Ayda 4 Kere Ziyaret)</option>");
            });

            Eczane_Liste_Ekle_btn.click(function () {
                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Eczane_Liste_Ekle_btn',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Eczane_Liste_Eczane.find('option:selected').val() + "-" + Eczane_Liste_Frekans.find('option:selected').attr('value') + "-" + Eczane_Liste_Olustur_Liste.find('option:selected').attr('value') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {


                        if (data.d == "0") {
                            alert("Doktor Daha Önceden Bu listeye eklenmiş")
                        }
                        else {

                            if (tablo_kontrol == false) {
                                Eczane_Listesi_Tablosu.children().empty();
                                Eczane_Listesi_Tablosu.children().append("<tr><th>#</th><th>Eczane Adı</th><th>Brick</th><th>Frekans</th><th>Kaldır</th></tr>")
                                Eczane_Listesi_Tablosu.children().append("<tr><td></td><td>" + Eczane_Liste_Eczane.find('option:selected').text() + "</td><td>" + Eczane_Liste_Brick.find('option:selected').text() + "</td><td>" + Eczane_Liste_Frekans.find('option:selected').attr('value') + "</td>/<td> <a style='font-size: 20px; ' id='Eczaneyi_Kaldır' value='" + data.d.split('-')[0] + "'><i class='fa fa-trash-o'></i></a></td></tr>")


                            }
                            else {
                                tablo_kontrol = true;
                                Eczane_Listesi_Tablosu.children().append("<tr><td></td><td>" + Eczane_Liste_Eczane.find('option:selected').text() + "</td><td>" + Eczane_Liste_Brick.find('option:selected').text() + "</td><td>" + Eczane_Liste_Frekans.find('option:selected').attr('value') + "</td>/<td> <a style='font-size: 20px; ' id='Eczaneyi_Kaldır' value='" + data.d.split('-')[0] + "'><i class='fa fa-trash-o'></i></a></td></tr>")
                            }

                        }
                        var Eczaneyi_Kaldır = Eczane_Listesi_Tablosu.children().find($('a[id=Eczaneyi_Kaldır]'));

                        Eczaneyi_Kaldır.click(function () {
                          
                            
                            $.ajax({
                                url: 'Eczane-Liste-Olustur.aspx/Eczaneyi_Listeden_Kaldır',
                                dataType: 'json',
                                type: 'POST',
                                data: "{'parametre': '" + $(this).attr('value') + "'}",
                                contentType: 'application/json; charset=utf-8',
                                success: function (data) {
                                    var Eczaneyi_Kaldır = Eczane_Listesi_Tablosu.children().find($('a[value=' + data.d + ']'))

                                    if (data.d == "0") {
                                        alert("İşlem Başarısız Lütfen Daha Sonra Tekrar Deneyiniz");
                                    }
                                    else {
                                        Eczaneyi_Kaldır.parent().parent().empty();
                                    }

                                }
                            });



                        });






                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });


            $.ajax({
                url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '" + "-0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var b = 0;
                    while (data.d.split('!')[b] != null) {
                        Eczane_Liste_Olustur_Liste.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;
                    }

                    $.ajax({
                        url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Listeler_Tablo',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + Eczane_Liste_Olustur_Liste.find('option:selected').attr('value') + "-" + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            if (data.d == "Lütfen - Listeye -  Doktor - Ekleyiniz-0-0") {
                                tablo_kontrol = false;
                            }
                            //<td> <a style="font-size: 20px;" value='data.d.split('!')[b].split('-')[6]'><i class="fa fa-trash-o"></i></a>  </td >



                            var b = 0;
                            while (data.d.split('!')[b] != null) {

                                Eczane_Listesi_Tablosu.children().append("<tr><td></td><td>" + data.d.split('!')[b].split('-')[0] + "</td><td>" + data.d.split('!')[b].split('-')[1] + "</td><td>" + data.d.split('!')[b].split('-')[2] + "</td><td> <a style='font-size: 20px; ' id='Eczaneyi_Kaldır' value='" + data.d.split('!')[b].split('-')[3] + "'><i class='fa fa-trash-o'></i></a>  </td></tr>")
                                b++;
                            } //doktorları listelerken tersten listele 

                            var Doktoru_Kaldır = Eczane_Listesi_Tablosu.children().find($('a[id=Eczaneyi_Kaldır]'));

                            Doktoru_Kaldır.click(function () {
                                $.ajax({
                                    url: 'Eczane-Liste-Olustur.aspx/Eczaneyi_Listeden_Kaldır',
                                    dataType: 'json',
                                    type: 'POST',
                                    data: "{'parametre': '" + $(this).attr('value') + "'}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {
                                        var Doktoru_Kaldır = Eczane_Listesi_Tablosu.children().find($('a[value=' + data.d + ']'))

                                        if (data.d == "0") {
                                            alert("İşlem Başarısız Lütfen Daha Sonra Tekrar Deneyiniz");
                                        }
                                        else {
                                            Doktoru_Kaldır.parent().parent().empty();
                                        }

                                    }
                                });



                            });


                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });


            Eczane_Yeni_Liste_Olustur_Modal_btn.click(function () {


                //Doktor_Yeni_Liste_Input.val() //doktorları listelerken tersten listele 

                $.ajax({
                    url: 'Eczane-Liste-Olustur.aspx/Yeni_Liste_Olustur_Liste_Ekle',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + Eczane_Yeni_Liste_Input.val() + "-" + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Eczane_Liste_Olustur_Liste.append("<option id='" + data.d + "'>" + Eczane_Yeni_Liste_Input.val() + "</option>")

                        Eczane_Liste_Olustur_Liste.find($('option[id=' + data.d + ']')).attr('selected', 'selected');


                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        //doktorları listelerken tersten listele 
                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });


            });




        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Modal -->
    <div id="Eczane_Yeni_Liste_Ekle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Lütfen Liste Adı Giriniz</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Liste Adı</label>
                        <input id="Eczane_Yeni_Liste_Input" type="text" class="form-control" placeholder="4 Frekans Eczaneler . . ." />
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="Eczane_Yeni_Liste_Olustur_Modal_btn" type="button" class="btn btn-default" data-dismiss="modal">Ekle</button>
                </div>
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="box box-info box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">Eczane Listesi Oluştur</h3>
                    <div class="box-tools pull-right">
                    </div>
                    <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Liste Belirleyiniz</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-9">
                            <div class="form-group">
                                <select id="Eczane_Liste_Olustur_Liste" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-3">
                            <div class="form-group">
                                <button type="button" class="btn btn-info pull-right" data-toggle="modal" data-target="#Eczane_Yeni_Liste_Ekle_Modal">Yeni Liste Oluştur</button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen İL Seçiniz</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <select id="Eczane_Liste_Il" class="form-control"></select>
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
                                <select  id="Eczane_Liste_Brick" class="form-control"></select>
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
                                <select id="Eczane_Liste_Eczane" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Frekans Seçiniz</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <select id="Eczane_Liste_Frekans" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <a id="Eczane_Liste_Ekle_btn" class="btn btn-info pull-right">Seçilen Doktoru Listeye Ekle</a>
                            </div>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="box">
                            <div class="box-body table-responsive no-padding">
                                <table id="Eczane_Listesi_Tablosu" class="table table-hover">
                                    <tbody>
                                        <tr>
                                            <th>#</th>
                                            <th>Eczane Adı</th>
                                            <th>Brick</th>
                                            <th>Frekans</th>
                                            <th>Kaldır</th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>

</asp:Content>
