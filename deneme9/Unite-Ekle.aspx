<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Unite-Ekle.aspx.cs" Inherits="deneme9.Unite_Ekle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="">
        $(document).ready(function () {
            
            var Doktor_Liste_Olustur_Liste = $('select[id=Doktor_Liste_Olustur_Liste]');
            var Doktor_Liste_Il = $('select[id=Doktor_Liste_Il]');
            Doktor_Liste_Il.append("<option value='0'>Lütfen İl Seçiniz</option>");
            var Doktor_Liste_Brick = $('select[id=Doktor_Liste_Brick]');
          



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

                        $('#Doktor_Liste_Il').append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
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

                        $('#Doktor_Liste_Brick').empty();
                        $('#Doktor_Liste_Brick').append("<option value='0'>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            $('#Doktor_Liste_Brick').append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if ($('#Doktor_Liste_Il').parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            $('#Doktor_Liste_Il').parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });

            $('#Doktor_Liste_Ekle_btn').click(function () {

                if ($('#Ünite_Adı').val()=="") {
                    Swal.fire({
                        title: 'Hata!',
                        text: 'Lütfen Tüm Alanları Doldurunuz',
                        icon: 'error',
                        confirmButtonText: 'Kapat'
                    })
                }
                else {
                    $.ajax({
                        url: 'Unite-Ekle.aspx/Unite_Ekle_Yeni',
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{" +
                            "'İl': '" + $('select[id=Doktor_Liste_Il]').find('option:selected').attr('value') + "'," +
                            "'Brick':'" + $('select[id=Doktor_Liste_Brick]').find('option:selected').attr('value') + "'," +
                            "'Ünite_Adı':'" + $('#Ünite_Adı').val() + "'" +
                            "}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            Swal.fire({
                                title: 'Başarılı!',
                                text: 'İşlem Başarı İle Kaydedildi',
                                icon: 'success',
                                confirmButtonText: 'Kapat'
                            })
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
                        Ünite Eklemek İstediğinizden Eminmisiniz ?

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Siparişi_Oluştur_Modal" class="btn btn-primary">Üniteyi Ekle</button>
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
                                <select name="Select" id="Doktor_Liste_Il"  class="form-control"></select>
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
                            <label>Lütfen Ünite Adı Giriniz</label>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <input name="İnput" type="text" id="Ünite_Adı" Zorunlu="1" class="form-control"></input>
                            </div>
                        </div>
                    </div>

                 




                    <div class="row">
                        <div class="col-xs-12">
                            <div class="form-group">
                                <a id="Doktor_Liste_Ekle_btn" class="btn btn-info pull-right">Üniteyi Ekle</a>
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
