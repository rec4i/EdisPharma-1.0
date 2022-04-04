<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Uniteye-Branş-Ekle.aspx.cs" Inherits="deneme9.Uniteye_Branş_Ekle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="">
        $(document).ready(function () {
            var Doktor_Yeni_Liste_Olustur_Modal_btn = $('button[id=Doktor_Yeni_Liste_Olustur_Modal_btn]'); //doktorları listelerken tersten listele 
            var Doktor_Liste_Olustur_Liste = $('select[id=Doktor_Liste_Olustur_Liste]');
            var Doktor_Yeni_Liste_Input = $('input[id=Doktor_Yeni_Liste_Input]');
            var Doktor_Listesi_Tablosu = $('table[id=Doktor_Listesi_Tablosu]');
            var Doktor_Liste_Ekle_btn = $('a[id=Doktor_Liste_Ekle_btn]') //doktorları listelerken tersten listele 
            var Doktor_Liste_Il = $('select[id=Doktor_Liste_Il]');
            Doktor_Liste_Il.append("<option value='0'>Lütfen İl Seçiniz</option>");
            var Doktor_Liste_Brick = $('select[id=Doktor_Liste_Brick]');
            var Doktor_Liste_Untie = $('select[id=Doktor_Liste_Untie]');
            var Doktor_Liste_Brans = $('select[id=Doktor_Liste_Brans]');
            var Doktor_Liste_Doktor_Ad = $('select[id=Doktor_Liste_Doktor_Ad]');
            var Doktor_Liste_Frekans = $('select[id=Doktor_Liste_Frekans]');
            var tablo_kontrol = true;



            //doktorları listelerken tersten listele 
            Doktor_Liste_Olustur_Liste.empty()





            //doktorları listelerken tersten listele 

            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                

                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Doktor_Liste_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Doktor_Liste_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Liste_Brick.empty();
                        Doktor_Liste_Brick.append("<option value='0'>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Doktor_Liste_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Doktor_Liste_Il.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Doktor_Liste_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Doktor_Liste_Brick.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '2-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Liste_Untie.empty();
                        Doktor_Liste_Untie.append("<option>Lütfen Ünite Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Doktor_Liste_Untie.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Liste_Brick.parent().children().find($("select option:first-child")).html() == "Lütfen Brick Seçiniz") {
                            Doktor_Liste_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });//Doktor_Liste_Brans
            Doktor_Liste_Untie.change(function () {
                console.log("asd")
                $.ajax({
                    url: 'Uniteye-Branş-Ekle.aspx/Branş_Listesi',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Şehir_Id': '3-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var temp = JSON.parse(data.d)

                        Doktor_Liste_Brans.empty();
                        Doktor_Liste_Brans.append("<option>Lütfen Branş Seçiniz</option>");
                        for (var i = 0; i < temp.length; i++) {
                            Doktor_Liste_Brans.append("<option value='" + temp[i].Branş_Id + "'>" + temp[i].Branş_Txt + "</option>");
                        }

                      


                        if (Doktor_Liste_Untie.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Doktor_Liste_Untie.parent().children().find($("select option:first-child")).remove();
                        }

                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        if (Doktor_Liste_Untie.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Doktor_Liste_Untie.parent().children().find($("select option:first-child")).remove();
                        }

                    }
                });

            });

           


            Doktor_Liste_Ekle_btn.click(function () {
              
                var Gönderilsinmi = true;
                var Kapansınmı = 0;
                $('select[name*=Select]').each(function () {

                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }
                   
                });
                if (Gönderilsinmi==true) {
                    $('#myModal').modal('show')
                }
            });
            var Siparişi_Oluştur_Modal = $('button[id=Siparişi_Oluştur_Modal]')
            Siparişi_Oluştur_Modal.click(function () {
                console.log("asds")
                var Gönderilsinmi = true;
                var Kapansınmı = 0;
              
         
                $('select[name*=Select]').each(function () {

                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }
                    if (Kapansınmı == 1) {
                        $('#myModal').modal('toggle')
                    }
                });
                
   

                if (Gönderilsinmi == true) {
                    $.ajax({
                        url: 'Uniteye-Branş-Ekle.aspx/Branşı_Ekle',
                        dataType: 'json',
                        type: 'POST',
                        data: "{" +
                            "'İl': '" + Doktor_Liste_Il.find('opion:selected').val() + "'," +
                            "'Brick':'" + Doktor_Liste_Brick.find('opion:selected').val() + "'," +
                            "'Ünite_Adı':'" + $('select[id=Doktor_Liste_Untie]').find('option:selected').val() + "'," +
                            "'Doktor_Liste_Brans':'" + $('select[id=Doktor_Liste_Brans]').find('option:selected').val() + "'" +
                            "}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            $('#myModal').modal('toggle')
                            $('#İşlem_Başarılı').modal('show')
                        },
                        error: function () {


                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                            $('#myModal').modal('toggle')
                         
                        }
                    });
                }

               
            })




            
        })
    </script>

    <style>
        .vertical-alignment-helper {
            display: table;
            height: 100%;
            width: 100%;
            pointer-events: none;
        }

        .vertical-align-center {
            /* To center vertically */
            display: table-cell;
            vertical-align: middle;
            pointer-events: none;
        }

        .modal-content {
            /* Bootstrap sets the size of the modal in the modal-dialog class, we need to inherit it */
            width: inherit;
            max-width: inherit; /* For Bootstrap 4 - to avoid the modal window stretching full width */
            height: inherit;
            /* To center horizontally */
            margin: 0 auto;
            pointer-events: all;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="myModalLabel">Siparişi Oluştur</h4>

                    </div>
                    <div class="modal-body">
                        Branşı Eklemek İstediğinizden Eminmisiniz ?

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Siparişi_Oluştur_Modal" class="btn btn-primary">Branşı Ekle</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="İşlem_Başarılı" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="İşlem_Başarılı_label">İşlem Sonucu</h4>

                    </div>
                    <div class="modal-body">
                        İşelem Başarılı

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="box box-info box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">Ünite Ekle</h3>
                    <div class="box-tools pull-right">
                    </div>
                    <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen İL Seçiniz</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <select name="Select" id="Doktor_Liste_Il" class="form-control"></select>
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
                                <select name="Select" id="Doktor_Liste_Brick" class="form-control"></select>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Ünite Seçiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <select name="Select" id="Doktor_Liste_Untie" class="form-control"></select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-12">
                            <label>Lütfen Branş Seçiniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <select name="Select" id="Doktor_Liste_Brans" class="form-control"></select>
                            </div>
                        </div>
                    </div>



                       <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">

                                <a id="Doktor_Liste_Ekle_btn" class="btn btn-info pull-right">Branşı Ekle</a>
                            </div>
                        </div>
                    </div>





                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
    </div>

</asp:Content>
