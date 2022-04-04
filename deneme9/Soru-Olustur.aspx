<%@ Page Title="" Language="C#" MasterPageFile="~/bs.Master" AutoEventWireup="true" CodeBehind="Soru-Olustur.aspx.cs" Inherits="deneme9.Soru_Olustur" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var Sorular_Liste_Select = $('select[id=Sorular_Liste_Select]');

            $.ajax({
                url: 'Soru-Olustur.aspx/Sorular_Listeleri_Listele',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': ''}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var b = 0;
                    while (data.d.split('!')[b] != null) {
                        Sorular_Liste_Select.append('<option value=' + data.d.split('!')[b].split('-')[0] + '>' + data.d.split('!')[b].split('-')[1] + '</option>')
                        b++;
                    }
                    $.ajax({
                        url: 'Soru-Olustur.aspx/Soruları_Tabloya_doldur',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + Sorular_Liste_Select.find('option:selected').val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            if (data.d!="") {
                                var b = 0;
                                while (data.d.split('!')[b] != null) {
                                    Soru_Tablo.append('<tr><td>' + (b + 1) + '</td>' +
                                        '<td>' + data.d.split('!')[b].split('-')[0] + '</td>' +
                                        '<td>' + data.d.split('!')[b].split('-')[1] + '</td>' +
                                        '<td><a value="' + data.d.split('!')[b].split('-')[2] + '" id="Soruyu_İncele" ><i class="fa fa fa-search"></i></a></td>' +
                                        '<td><a style="font-size: 20px;" value="' + data.d.split('!')[b].split('-')[2] + '" id="Soruyu_Kaldır" ><i class="fa fa-trash-o"></i></a></td>' +
                                        '</tr>')
                                    b++;
                                }
                                var Soruyu_İncele = Soru_Tablo.find($('a[id*=Soruyu_İncele]'))
                                var Soruyu_Kaldır = Soru_Tablo.find($('a[id*=Soruyu_Kaldır]'))


                                Soruyu_İncele.on('click', function () {
                                    $.ajax({
                                        url: 'Soru-Olustur.aspx/Soru_İncele',
                                        dataType: 'json',
                                        type: 'POST',
                                        data: "{'parametre': '" + $(this).attr('value') + "'}",
                                        contentType: 'application/json; charset=utf-8',
                                        success: function (data) {
                                            var Soru = $('textarea[id=Modal_Soru]')
                                            var Sık_1 = $('input[id=Modal_Sık_1]')
                                            var Sık_2 = $('input[id=Modal_Sık_2]')
                                            var Sık_3 = $('input[id=Modal_Sık_3]')
                                            var Sık_4 = $('input[id=Modal_Sık_4]')
                                            var Sık_5 = $('input[id=Modal_Sık_5]')
                                            Soru.val(data.d.split('!')[0].split('-')[2]);
                                            Sık_1.val(data.d.split('!')[0].split('-')[3]);
                                            Sık_2.val(data.d.split('!')[1].split('-')[3]);
                                            Sık_3.val(data.d.split('!')[2].split('-')[3]);
                                            Sık_4.val(data.d.split('!')[3].split('-')[3]);
                                            Sık_5.val(data.d.split('!')[4].split('-')[3]);

                                        },
                                        error: function () {
                                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                        }
                                    });//Soru_İncele

                                    $('#Soru_İncele').modal('show');
                                });
                                Soruyu_Kaldır.on('click', function () {
                                    $(this).parent().parent().remove();

                                    $.ajax({
                                        url: 'Soru-Olustur.aspx/Soru_Kaldır',
                                        dataType: 'json',
                                        type: 'POST',
                                        data: "{'parametre': '" + $(this).attr('value') + "'}",
                                        contentType: 'application/json; charset=utf-8',
                                        success: function (data) {//Mesaj

                                            $('#Mesaj').modal('show');

                                        },
                                        error: function () {
                                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                        }
                                    });//Soru_İncele
                                });
                            }
                            
                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                            Soru_Liste_Ad_input.val('')

                        }
                    });

                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Sorular_Liste_Select.on('change', function () {
                $.ajax({
                    url: 'Soru-Olustur.aspx/Soruları_Tabloya_doldur',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '" + $(this).find('option:selected').val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Soru_Tablo.empty();
                        Soru_Tablo.append('<tr>  <th>#</th>  <th>Soru</th><th>Doğru Şık</th> <th>İncele/Düzenle</th> <th>Sil</th></tr>');

                        if (data.d != "") {
                            var b = 0;
                            while (data.d.split('!')[b] != null) {
                                Soru_Tablo.append('<tr><td>' + (b + 1) + '</td>' +
                                    '<td>' + data.d.split('!')[b].split('-')[0] + '</td>' +
                                    '<td>' + data.d.split('!')[b].split('-')[1] + '</td>' +
                                    '<td><a value="' + data.d.split('!')[b].split('-')[2] + '" id="Soruyu_İncele" ><i class="fa fa fa-search"></i></a></td>' +
                                    '<td><a style="font-size: 20px;" value="' + data.d.split('!')[b].split('-')[2] + '" id="Soruyu_Kaldır" ><i class="fa fa-trash-o"></i></a></td>' +
                                    '</tr>')
                                b++;
                            }
                            var Soruyu_İncele = Soru_Tablo.find($('a[id*=Soruyu_İncele]'))
                            var Soruyu_Kaldır = Soru_Tablo.find($('a[id*=Soruyu_Kaldır]'))


                            Soruyu_İncele.on('click', function () {

                                $.ajax({
                                    url: 'Soru-Olustur.aspx/Soru_İncele',
                                    dataType: 'json',
                                    type: 'POST',
                                    data: "{'parametre': '" + $(this).attr('value') + "'}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {

                                        var Soru = $('textarea[id=Modal_Soru]')
                                        var Sık_1 = $('input[id=Modal_Sık_1]')
                                        var Sık_2 = $('input[id=Modal_Sık_2]')
                                        var Sık_3 = $('input[id=Modal_Sık_3]')
                                        var Sık_4 = $('input[id=Modal_Sık_4]')
                                        var Sık_5 = $('input[id=Modal_Sık_5]')
                                        Soru.val(data.d.split('!')[0].split('-')[2]);
                                        Sık_1.val(data.d.split('!')[0].split('-')[3]);
                                        Sık_2.val(data.d.split('!')[1].split('-')[3]);
                                        Sık_3.val(data.d.split('!')[2].split('-')[3]);
                                        Sık_4.val(data.d.split('!')[3].split('-')[3]);
                                        Sık_5.val(data.d.split('!')[4].split('-')[3]);

                                    },
                                    error: function () {
                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });//Soru_İncele

                                $('#Soru_İncele').modal('show');

                            });
                            Soruyu_Kaldır.on('click', function () {
                                $(this).parent().parent().remove();

                                $.ajax({
                                    url: 'Soru-Olustur.aspx/Soru_Kaldır',
                                    dataType: 'json',
                                    type: 'POST',
                                    data: "{'parametre': '" + $(this).attr('value') + "'}",
                                    contentType: 'application/json; charset=utf-8',
                                    success: function (data) {//Mesaj


                                        $('#Mesaj').modal('show');

                                    },
                                    error: function () {
                                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                    }
                                });//Soru_İncele

                            });
                        }

                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        Soru_Liste_Ad_input.val('')

                    }
                });

            });


            var Soru_Liste_Ad_input = $('input[id=Soru_Liste_Ad_input]')
            var Soru_Liste_Ad_Button = $('button[id=Soru_Liste_Ad_Button]')
            Soru_Liste_Ad_Button.on('click', function () {

                if (Soru_Liste_Ad_input.val() != "") {
                    $.ajax({
                        url: 'Soru-Olustur.aspx/Sorular_Yeni_Soru_Ekle',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + Soru_Liste_Ad_input.val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            Sorular_Liste_Select.empty()
                            var b = 0;
                            while (data.d.split('!')[b] != null) {
                                Sorular_Liste_Select.append('<option value=' + data.d.split('!')[b].split('-')[0] + '>' + data.d.split('!')[b].split('-')[1] + '</option>')
                                b++;
                            }
                            $('#Soru_Liste_Ekle_Modal').modal('toggle');
                            Soru_Liste_Ad_input.val('')

                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                            Soru_Liste_Ad_input.val('')

                        }
                    });
                }
                else {
                    alert("Liste Adı Boş Bırakılamaz")
                }
            });

            var Soru_Tablo = $('tbody[id=Soru_Tablo]');
            var Soruyu_Ekle = $('button[id=Soruyu_Ekle]');
            var Soru = $('textarea[id=Soru]')
            var Sık_1 = $('input[id=Sık_1]')
            var Sık_2 = $('input[id=Sık_2]')
            var Sık_3 = $('input[id=Sık_3]')
            var Sık_4 = $('input[id=Sık_4]')
            var Sık_5 = $('input[id=Sık_5]')
            Soruyu_Ekle.on('click', function () {//form-group has-error


                var Soru_Kont = true, Sık_1_Kont = true, Sık_2_Kont = true, Sık_3_Kont = true, Sık_4_Kont = true, Sık_5_Kont = true;

                if (Soru.val() == "") {
                    Soru_Kont = false;
                    Soru.parent().removeAttr('class');
                    Soru.parent().attr('class', 'form-group has-error');
                }
                if (Sık_1.val() == "") {
                    Sık_1_Kont = false;
                    Sık_1.parent().removeAttr('class')
                    Sık_1.parent().attr('class', 'form-group has-error')
                }
                if (Sık_2.val() == "") {
                    Sık_2_Kont = false;
                    Sık_2.parent().removeAttr('class')
                    Sık_2.parent().attr('class', 'form-group has-error')
                }
                if (Sık_3.val() == "") {
                    Sık_3_Kont = false;
                    Sık_3.parent().removeAttr('class')
                    Sık_3.parent().attr('class', 'form-group has-error')
                }
                if (Sık_4.val() == "") {
                    Sık_4_Kont = false;
                    Sık_4.parent().removeAttr('class')
                    Sık_4.parent().attr('class', 'form-group has-error')
                }
                if (Sık_5.val() == "") {
                    Sık_5_Kont = false;
                    Sık_5.parent().removeAttr('class')
                    Sık_5.parent().attr('class', 'form-group has-error')
                }
                if (Soru_Kont == true && Sık_1_Kont == true && Sık_2_Kont == true && Sık_3_Kont == true && Sık_4_Kont == true && Sık_5_Kont == true) {

                    $.ajax({
                        url: 'Soru-Olustur.aspx/Sorular_Yeni_Liste_Ekle',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + Sorular_Liste_Select.find('option:selected').val() + "-" + Soru.val() + "-" + Sık_1.val() + "-" + Sık_2.val() + "-" + Sık_3.val() + "-" + Sık_4.val() + "-" + Sık_5.val() + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            if (data.d!="") {
                                Soru_Tablo.empty();
                                Soru_Tablo.append('<tr><th>#</th><th>Soru</th><th>Doğru Şık</th><th>İncele/Düzenle</th><th>Sil</th></tr>')
                                var b = 0;
                                while (data.d.split('!')[b] != null) {
                                    Soru_Tablo.append('<tr><td>' + (b + 1) + '</td>' +
                                        '<td>' + data.d.split('!')[b].split('-')[0] + '</td>' +
                                        '<td>' + data.d.split('!')[b].split('-')[1] + '</td>' +
                                        '<td><a value="' + data.d.split('!')[b].split('-')[2] + '" id="Soruyu_İncele" ><i class="fa fa fa-search"></i></a></td>' +
                                        '<td><a style="font-size: 20px;" value="' + data.d.split('!')[b].split('-')[2] + '" id="Soruyu_Kaldır" ><i class="fa fa-trash-o"></i></a></td>' +
                                        '</tr>')
                                    b++;
                                }
                                var Soruyu_İncele = Soru_Tablo.find($('a[id*=Soruyu_İncele]'))
                                var Soruyu_Kaldır = Soru_Tablo.find($('a[id*=Soruyu_Kaldır]'))

                                Soruyu_İncele.on('click', function () {
                                    $.ajax({
                                        url: 'Soru-Olustur.aspx/Soru_İncele',
                                        dataType: 'json',
                                        type: 'POST',
                                        data: "{'parametre': '" + $(this).attr('value') + "'}",
                                        contentType: 'application/json; charset=utf-8',
                                        success: function (data) {

                                            var Soru = $('textarea[id=Modal_Soru]')
                                            var Sık_1 = $('input[id=Modal_Sık_1]')
                                            var Sık_2 = $('input[id=Modal_Sık_2]')
                                            var Sık_3 = $('input[id=Modal_Sık_3]')
                                            var Sık_4 = $('input[id=Modal_Sık_4]')
                                            var Sık_5 = $('input[id=Modal_Sık_5]')
                                            Soru.val(data.d.split('!')[0].split('-')[2]);
                                            Sık_1.val(data.d.split('!')[0].split('-')[3]);
                                            Sık_2.val(data.d.split('!')[1].split('-')[3]);
                                            Sık_3.val(data.d.split('!')[2].split('-')[3]);
                                            Sık_4.val(data.d.split('!')[3].split('-')[3]);
                                            Sık_5.val(data.d.split('!')[4].split('-')[3]);

                                        },
                                        error: function () {
                                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                        }
                                    });//Soru_İncele

                                    $('#Soru_İncele').modal('show');
                                });
                                Soruyu_Kaldır.on('click', function () {
                                    $(this).parent().parent().remove();

                                    $.ajax({
                                        url: 'Soru-Olustur.aspx/Soru_Kaldır',
                                        dataType: 'json',
                                        type: 'POST',
                                        data: "{'parametre': '" + $(this).attr('value') + "'}",
                                        contentType: 'application/json; charset=utf-8',
                                        success: function (data) {//Mesaj

                                            $('#Mesaj').modal('show');

                                        },
                                        error: function () {
                                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                                        }
                                    });//Soru_İncele
                                });
                            }
                           
                        },
                        error: function () {
                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                            Soru_Liste_Ad_input.val('')
                        }
                    });

                    Soru.val('')
                    Sık_1.val('')
                    Sık_2.val('')
                    Sık_3.val('')
                    Sık_4.val('')
                    Sık_5.val('')
                    Soru.parent().removeAttr('class');
                    Soru.parent().attr('class', 'form-group');
                    Sık_1.parent().removeAttr('class')
                    Sık_1.parent().attr('class', 'form-group')
                    Sık_2.parent().removeAttr('class')
                    Sık_2.parent().attr('class', 'form-group')
                    Sık_3.parent().removeAttr('class')
                    Sık_3.parent().attr('class', 'form-group')
                    Sık_4.parent().removeAttr('class')
                    Sık_4.parent().attr('class', 'form-group')
                    Sık_5.parent().removeAttr('class')
                    Sık_5.parent().attr('class', 'form-group')

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
                    <p>İşlem Başarıyla DataBase'e İşlenmiştir</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
    <div id="Soru_Liste_Ekle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Yeni Liste Oluştur</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Liste Adı</label>
                        <input id="Soru_Liste_Ad_input" type="text" class="form-control" placeholder="Büyük Soru Listesi . . ." />
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="Soru_Liste_Ad_Button" type="button" class="btn btn-default">Ekle</button>
                </div>
            </div>

        </div>
    </div>
    <div id="Soru_İncele" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Yeni Liste Oluştur</h4>
                </div>
                <div class="modal-body">

                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label>Soru</label>
                                <textarea id="Modal_Soru" class="form-control" rows="3" placeholder="Enter ..."></textarea>
                            </div>
                        </div>

                    </div>
                    <div class="form-group">
                        <label>1. Şık(Doğru Cevap)</label>
                        <input id="Modal_Sık_1" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                    <div class="form-group">
                        <label>2. Şık</label>
                        <input id="Modal_Sık_2" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                    <div class="form-group">
                        <label>3. Şık</label>
                        <input id="Modal_Sık_3" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                    <div class="form-group">
                        <label>4. Şık</label>
                        <input id="Modal_Sık_4" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                    <div class="form-group">
                        <label>5. Şık</label>
                        <input id="Modal_Sık_5" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="Kapat" data-dismiss="modal" type="button" class="btn btn-default">Kapat</button>
                </div>
            </div>

        </div>
    </div>


    <div class="row">
        <div class="col-md-12">
            <div class="box box-info">
                <div class="box-header with-border" style="background-color: #f4f4f4 !important">
                    <h3 class="box-title">Soru Ekle</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-9">
                            <div class="form-group">
                                <select id="Sorular_Liste_Select" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-3">
                            <div class="form-group">
                                <button type="button" class="btn btn-info pull-right" data-toggle="modal" data-target="#Soru_Liste_Ekle_Modal">Yeni Liste Oluştur</button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label>Soru</label>
                                <textarea id="Soru" class="form-control" rows="3" placeholder="Enter ..."></textarea>
                            </div>
                        </div>

                    </div>
                    <div class="form-group">
                        <label>1. Şık(Doğru Cevap)</label>
                        <input id="Sık_1" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                    <div class="form-group">
                        <label>2. Şık</label>
                        <input id="Sık_2" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                    <div class="form-group">
                        <label>3. Şık</label>
                        <input id="Sık_3" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                    <div class="form-group">
                        <label>4. Şık</label>
                        <input id="Sık_4" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                    <div class="form-group">
                        <label>5. Şık</label>
                        <input id="Sık_5" type="text" class="form-control" placeholder="Enter ..." />
                    </div>
                </div>
                <!-- /.box-body -->
                <div class="box-footer">

                    <button id="Soruyu_Ekle" onclick="return false;" class="btn btn-default">Ekle</button>
                </div>
                <!-- /.box-footer -->
            </div>

        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="box box-info">
                <div class="box-header with-border" style="background-color: #f4f4f4 !important">
                    <h3 class="box-title">Sorular</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="box-body no-padding table-responsive">
                                <div class="box">
                                    <table class="table table-condensed">
                                        <tbody id="Soru_Tablo">
                                            <tr>
                                                <th>#</th>
                                                <th>Soru</th>
                                                <th>Doğru Şık</th>
                                                <th>İncele/Düzenle</th>
                                                <th>Sil</th>
                                            </tr>


                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.box-body -->
                <div class="box-footer">
                </div>
                <!-- /.box-footer -->
            </div>

        </div>
    </div>
</asp:Content>
