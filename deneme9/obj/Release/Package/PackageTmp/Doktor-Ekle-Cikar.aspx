<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Doktor-Ekle-Cikar.aspx.cs" Inherits="deneme9.Doktor_Ekle_Cikar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        

        $(document).ready(function () {
            

           
            let Myset = new Set();
            Myset.add(1,2)
            Myset.add(2)
            Myset.add(3)
            Myset.add(4)
            for (let item of Myset) console.log(item)

            var Doktor_Ekle_Il = $('select[id*=Doktor_Ekle_il]')
            Doktor_Ekle_Il.append("<option>Lütfen İl Seçiniz</option>");


            var Doktor_Ekle_Brick = $('select[id*=Doktor_Ekle_Brick]');

            var Doktor_Ekle_Unite = $('select[id*=Doktor_Ekle_Unite]');

            var Doktor_Ekle_Brans = $('select[id*=Doktor_Ekle_Brans]');//id="Doktor_Ekle_İşlem_Sonucu"

            var Doktor_Ekle_Ad = $('input[id*=Doktor_Ekle_Ad]');

            var Doktor_Ekle_İşlem_Sonucu = $('p[id*=Doktor_Ekle_İşlem_Sonucu]');

            var Doktoru_Ekle = $('a[id*=Doktoru_Ekle]');

            //---------------------------------------------------------------------

            var Doktor_Cıkar_Il = $('select[id*=Doktor_Cıkar_il]');
            Doktor_Cıkar_Il.append("<option>Lütfen İl Seçiniz</option>");

            var Doktor_Cıkar_Brick = $('select[id*=Doktor_Cıkar_Brick]');

            var Doktor_Cıkar_Unite = $('select[id*=Doktor_Cıkar_Unite]');

            var Doktor_Cıkar_Brans = $('select[id*=Doktor_Cıkar_Brans]');

            var Doktor_Cıkar_Ad = $('select[id*=Doktor_Cıkar_Ad]');

            var Doktor_Cıkar_İşlem_Sonucu = $('p[id*=Doktor_Cıkar_İşlem_Sonucu]');

            var Doktoru_Cıkar = $('a[id*=Doktoru_Cıkar]');
            //------------------------------------------------------

            var Düzenle_İl = $('select[id*=Düzenle_İl]');
            Düzenle_İl.append("<option>Lütfen İl Seçiniz</option>");

            var Düzenle_Brick = $('select[id*=Düzenle_Brick]');

            var Düzenle_Unite = $('select[id*=Düzenle_Unite]');

            var Doktor_Duzenle_Brans = $('select[id*=Doktor_Duzenle_Brans]');

            var Düzenle_Doktor = $('select[id*=Düzenle_Doktor]');

          
            var Doktor_Duzenle_Btn = $('a[id*=Doktor_Duzenle]');
            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {


                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Düzenle_İl.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Düzenle_İl.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Düzenle_Brick.empty();
                        Düzenle_Brick.append("<option>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Düzenle_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Düzenle_İl.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Düzenle_İl.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Düzenle_Brick.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '2-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Düzenle_Unite.empty();
                        Düzenle_Unite.append("<option>Lütfen Ünite Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Düzenle_Unite.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Düzenle_Brick.parent().children().find($("select option:first-child")).html() == "Lütfen Brick Seçiniz") {
                            Düzenle_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });
            Düzenle_Unite.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '3-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Duzenle_Brans.empty();
                        Doktor_Duzenle_Brans.append("<option>Lütfen Branş Seçiniz</option>");

                        var b = 0;
                        while (data.d.split('!')[b] != null) {


                            Doktor_Duzenle_Brans.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;

                        }


                        if (Düzenle_Unite.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Düzenle_Unite.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        if (Düzenle_Unite.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Düzenle_Unite.parent().children().find($("select option:first-child")).remove();
                        }

                    }
                });

            });
            Doktor_Duzenle_Brans.change(function () {

                $.ajax({
                    url: 'Doktor-Ekle-Cikar.aspx/Doktoru_Brans',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '4-" + $(this).val() + "-" + Düzenle_Unite.val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        console.log(data.d)
                        Düzenle_Doktor.empty();
                        Düzenle_Doktor.append(" <option>Lütfen Doktor Adı Seçiniz</option>");

                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Düzenle_Doktor.append("<option Doktor_Id=" + data.d.split('!')[b].split("-")[2] + " value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Cıkar_Brans.parent().children().find($("select option:first-child")).html() == "Lütfen Branş Seçiniz") {
                            Doktor_Cıkar_Brans.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });


            Doktor_Duzenle_Btn.click(function () {
                $('#Doktor_Düzenle_Modal').modal('show')
            })


             //-------------------------------------------------------------------------------------------------------
            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {


                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Doktor_Cıkar_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Doktor_Cıkar_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Cıkar_Brick.empty();
                        Doktor_Cıkar_Brick.append("<option>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Doktor_Cıkar_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Doktor_Cıkar_Il.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Doktor_Cıkar_Il.parent().children().find($("select option:first-child")).remove();
                        }
                    }
                });
            });
            Doktor_Cıkar_Brick.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '2-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Cıkar_Unite.empty();
                        Doktor_Cıkar_Unite.append("<option>Lütfen Ünite Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Doktor_Cıkar_Unite.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Cıkar_Brick.parent().children().find($("select option:first-child")).html() == "Lütfen Brick Seçiniz") {
                            Doktor_Cıkar_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });
            Doktor_Cıkar_Unite.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '3-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Cıkar_Brans.empty();
                        Doktor_Cıkar_Brans.append("<option>Lütfen Branş Seçiniz</option>");

                        var b = 0;
                        while (data.d.split('!')[b] != null) {


                            Doktor_Cıkar_Brans.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;

                        }

                        
                        if (Doktor_Cıkar_Unite.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Doktor_Cıkar_Unite.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                        if (Doktor_Cıkar_Unite.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Doktor_Cıkar_Unite.parent().children().find($("select option:first-child")).remove();
                        }

                    }
                });

            });
            Doktor_Cıkar_Brans.change(function () {

                $.ajax({
                    url: 'Doktor-Ekle-Cikar.aspx/Doktoru_Brans',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '4-" + $(this).val() + "-" + Doktor_Cıkar_Unite.val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Cıkar_Ad.empty();
                        Doktor_Cıkar_Ad.append(" <option>Lütfen Doktor Adı Seçiniz</option>");

                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Doktor_Cıkar_Ad.append("<option Doktor_Id=" + data.d.split('!')[b].split("-")[2] + " value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Cıkar_Brans.parent().children().find($("select option:first-child")).html() == "Lütfen Branş Seçiniz") {
                            Doktor_Cıkar_Brans.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });

            Doktoru_Cıkar.click(function () {

                var Gönderilsinmi = true;
                var Kapansınmı = 0;
                $('select[name*=Çıkar_Select]').each(function () {

                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }

                });



                if (Gönderilsinmi == true) {
                    $.ajax({
                        url: 'Doktor-Ekle-Cikar.aspx/Doktoru_Cıkar',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'parametre': '" + Doktor_Cıkar_Ad.find(':selected').attr('value') +"'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {


                            Doktor_Cıkar_İşlem_Sonucu.empty()
                            Doktor_Cıkar_İşlem_Sonucu.append("İşlem Başarıyla DataBase'e İşlendi")
                            $('#Doktor_Cıkar_Modal').modal('toggle');

                            Doktor_Cıkar_Brick.empty();
                            Doktor_Cıkar_Unite.empty();
                            Doktor_Cıkar_Brans.empty();
                            Doktor_Cıkar_Il.append("<option>Lütfen İl Seçiniz</option>");
                        },
                        error: function () {
                            Doktor_Cıkar_İşlem_Sonucu.empty()
                            Doktor_Cıkar_İşlem_Sonucu.append("İşlem DataBase'e İşlenirken Bit Hata Oluştu")
                            $('#Doktor_Cıkar_Modal').modal('toggle');
                            Doktor_Cıkar_Il.empty();
                            Doktor_Cıkar_Brick.empty();
                            Doktor_Cıkar_Unite.empty();
                            Doktor_Cıkar_Brans.empty();
                            Doktor_Cıkar_Il.append("<option>Lütfen İl Seçiniz</option>");

                        }
                    });
                }

            });



            //--------------------------------------------------------
            $.ajax({
                url: 'ddldeneme.aspx/OrnekPost',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': '0-0'}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {


                    var b = 0;
                    while (data.d.split('!')[b] != null) {

                        Doktor_Ekle_Il.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                        b++;

                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Doktor_Ekle_Il.change(function () {
                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '1-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        Doktor_Ekle_Brick.empty();
                        Doktor_Ekle_Brick.append("<option>Lütfen Brick Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {
                            Doktor_Ekle_Brick.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }

                        if (Doktor_Ekle_Il.parent().children().find($("select option:first-child")).html() == "Lütfen İl Seçiniz") {
                            Doktor_Ekle_Il.parent().children().find($("select option:first-child")).remove();
                        }


                    }
                });
            });
            Doktor_Ekle_Brick.change(function () {

                $.ajax({
                    url: 'ddldeneme.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '2-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Ekle_Unite.empty();
                        Doktor_Ekle_Unite.append("<option>Lütfen Ünite Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {

                            Doktor_Ekle_Unite.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;
                        }
                        if (Doktor_Ekle_Brick.parent().children().find($("select option:first-child")).html() == "Lütfen Brick Seçiniz") {
                            Doktor_Ekle_Brick.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });
            Doktor_Ekle_Unite.change(function () {
                $.ajax({
                    url: 'Doktor-Ekle-Cikar.aspx/OrnekPost',
                    dataType: 'json',
                    type: 'POST',
                    data: "{'parametre': '3-" + $(this).val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Doktor_Ekle_Brans.empty();
                        Doktor_Ekle_Brans.append("<option>Lütfen Branş Seçiniz</option>");
                        var b = 0;
                        while (data.d.split('!')[b] != null) {


                            Doktor_Ekle_Brans.append("<option value='" + data.d.split('!')[b].split("-")[0] + "'>" + data.d.split('!')[b].split("-")[1] + "</option>");
                            b++;

                        }
                        if (Doktor_Ekle_Unite.parent().children().find($("select option:first-child")).html() == "Lütfen Ünite Seçiniz") {
                            Doktor_Ekle_Unite.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });

            });

            Doktoru_Ekle.click(function () {
             
                var Gönderilsinmi = true;
                var Kapansınmı = 0;
                $('select[name*=Ekle_Select]').each(function () {

                    if ($(this).val() == "0" || $(this).val() == null) {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }
                    else {
                        $(this).parent().attr('class', 'form-group')
                    }
                   
                });
                $('input[name*=Ekle_İnput]').each(function () {

                    if ($(this).val() == "") {
                        Gönderilsinmi = false;
                        $(this).parent().attr('class', 'form-group has-error')
                        Kapansınmı++;
                    }

                    else {
                        $(this).parent().attr('class', 'form-group')
                    }
                });

                if (Gönderilsinmi == true) {
                    $.ajax({
                        url: 'Doktor-Ekle-Cikar.aspx/Doktoru_Ekle',
                        dataType: 'json',
                        type: 'POST',
                        data: "{" +
                            "'Doktor_Ad':'" + Doktor_Ekle_Ad.val() + "'," +
                            "'Doktor_Branş':'" + Doktor_Ekle_Brans.val() + "'," +
                            "'Doktor_Unite':'" + Doktor_Ekle_Unite.val() + "'" +
                            "}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            Doktor_Ekle_İşlem_Sonucu.empty();
                            Doktor_Ekle_İşlem_Sonucu.append("İşlem Başarıyla DataBase'e İşlendi")
                            $('#Doktor_Ekle_Modal').modal('toggle');

                            Doktor_Ekle_Brick.empty();
                            Doktor_Ekle_Unite.empty();
                            Doktor_Ekle_Brans.empty();
                            Doktor_Ekle_Ad.empty();
                        },
                        error: function () {
                            Doktor_Ekle_İşlem_Sonucu.append("İşlem DataBase'e İşlenirken Bit Hata Oluştu")
                            $('#Doktor_Ekle_Modal').modal('toggle');


                        }
                    });
                }
              

            });



        });




    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div id="Doktor_Düzenle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Doktor Düzenle</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İL Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select  name="Duzenle_Select" id="Düzenle_İl" class="form-control"></select>
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
                                    <select  name="Duzenle_Select" id="Düzenle_Brick" class="form-control"></select>
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
                                    <select  name="Duzenle_Select" id="Düzenle_Unite" class="form-control"></select>
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
                                    <select name="Duzenle_Select" id="Doktor_Duzenle_Brans" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Doktor Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select  name="Duzenle_Select" id="Düzenle_Doktor" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Doktor_Duzenle" class="btn btn-info pull-right">Seçilen Doktoru Düzenle</a>
                                </div>
                            </div>
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                </div>
            </div>

        </div>
    </div>

    <!-- Modal -->
    <div id="Doktor_Ekle_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">İşlem Sonucu</h4>
                </div>
                <div class="modal-body">
                    <p id="Doktor_Ekle_İşlem_Sonucu"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                </div>
            </div>

        </div>
    </div>

    <!-- Modal -->
    <div id="Doktor_Cıkar_Modal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">İşlem Sonucu</h4>
                </div>
                <div class="modal-body">
                    <p id="Doktor_Cıkar_İşlem_Sonucu"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
                </div>
            </div>

        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#tab_1" data-toggle="tab" aria-expanded="false">Doktor Düzenle
                        </a>
                    </li>
                    <li class=""><a href="#tab_2" data-toggle="tab" aria-expanded="true">Doktor Çıkar</a></li>
                    <li class=""><a href="#tab_3" data-toggle="tab" aria-expanded="false">Doktor Ekle</a></li>
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
                                    <select  name="Duzenle_Select" id="Düzenle_İl" class="form-control"></select>
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
                                    <select  name="Duzenle_Select" id="Düzenle_Brick" class="form-control"></select>
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
                                    <select  name="Duzenle_Select" id="Düzenle_Unite" class="form-control"></select>
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
                                    <select name="Duzenle_Select" id="Doktor_Duzenle_Brans" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Doktor Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select  name="Duzenle_Select" id="Düzenle_Doktor" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Doktor_Duzenle" class="btn btn-info pull-right">Seçilen Doktoru Düzenle</a>
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
                                    <select name="Çıkar_Select" id="Doktor_Cıkar_il" class="form-control"></select>
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
                                    <select name="Çıkar_Select" id="Doktor_Cıkar_Brick" class="form-control"></select>
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
                                    <select name="Çıkar_Select" id="Doktor_Cıkar_Unite" class="form-control"></select>
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
                                    <select name="Çıkar_Select" id="Doktor_Cıkar_Brans" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Doktor Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select name="Çıkar_Select" id="Doktor_Cıkar_Ad" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Doktoru_Cıkar" class="btn btn-info pull-right">Seçilen Doktoru Çıkar</a>
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
                                    <select name="Ekle_Select" id="Doktor_Ekle_il" class="form-control"></select>
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
                                    <select name="Ekle_Select" id="Doktor_Ekle_Brick" class="form-control"></select>
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
                                    <select name="Ekle_Select" id="Doktor_Ekle_Unite" class="form-control"></select>
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
                                    <select name="Ekle_Select" id="Doktor_Ekle_Brans" class="form-control"></select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen Doktor Adı Ve Ünvanını Giriniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input name="Ekle_İnput" id="Doktor_Ekle_Ad" type="text" class="form-control" placeholder="Doktor Adı Ve Ünvanı">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <a id="Doktoru_Ekle" class="btn btn-info pull-right">Doktoru Ekle</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
