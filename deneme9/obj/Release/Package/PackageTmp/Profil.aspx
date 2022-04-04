<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Profil.aspx.cs" Inherits="deneme9.Profil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    <script type="text/javascript">
        $(document).ready(function () {
            var Profil_Resimi = $('img[name=Profil_Resimi]')
            var Kullanıcı_Adı = $('td[name=Kullanıcı_Adı]')
            var Ad_Soyad = $('td[name=Ad_Soyad]')
            var Grup = $('td[name=Grup]')
            var Bolge = $('td[name=Bolge]')
            $.ajax({
                url: 'Profil.aspx/Profil_Bilgileri',
                dataType: 'json',
                type: 'POST',
                data: "{'parametre': ''}",
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var temp = JSON.parse(data.d)

                    Profil_Resimi.attr('src', temp[0].Kullanıcı_Profil_Photo)
                    Kullanıcı_Adı.html(temp[0].KullanıcıAD)
                    Ad_Soyad.html(temp[0].AD + ' ' + temp[0].Soyad)
                    Grup.html(temp[0].Grup_Tam_Ad + '(' + temp[0].Grup_Kısa_Ad + ')')
                    Bolge.text('' + temp[0].Bolge_Ad + '')


                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            var İşlem_Mesajı = $('label[id=İşlem_Mesajı]')
            var Sifre_Degistir = $('input[id=Sifre_Degistir]')
            Sifre_Degistir.click(function () {
                $('#Şifre_Değiştir_Modal').modal('show')
            })
            var Şifreyi_Değiştir = $('button[id=Şifreyi_Değiştir]')
            Şifreyi_Değiştir.click(function () {
                var Eski_Sifre = $('input[id=Eski_Sifre]')
                var Yeni_Sifre = $('input[id=Yeni_Sifre]')
                var Yeni_Sifre_Tekrar = $('input[id=Yeni_Sifre_Tekrar]')
                if (Eski_Sifre.val() == "" || Eski_Sifre.val() == undefined) {
                    Eski_Sifre.parent().attr('class', 'form-group has-error')
                }
                if (Yeni_Sifre.val() == "" || Yeni_Sifre.val() == undefined) {
                    Yeni_Sifre.parent().attr('class', 'form-group has-error')
                }
                if (Yeni_Sifre_Tekrar.val() == "" || Yeni_Sifre_Tekrar.val() == undefined) {
                    Yeni_Sifre_Tekrar.parent().attr('class', 'form-group has-error')
                }
                else {
                    Eski_Sifre.parent().attr('class', 'form-group ')
                    Yeni_Sifre.parent().attr('class', 'form-group')
                    Yeni_Sifre_Tekrar.parent().attr('class', 'form-group')
                    if (Yeni_Sifre.val() != Yeni_Sifre_Tekrar.val()) {
                        Yeni_Sifre.parent().attr('class', 'form-group has-error')
                        Yeni_Sifre_Tekrar.parent().attr('class', 'form-group has-error')
                    }
                    else {
                        $.ajax({
                            url: 'Profil.aspx/Şifre_Değiştir',
                            dataType: 'json',
                            type: 'POST',
                            data: "{'Eski_Sifre': '" + Eski_Sifre.val() + "','Yeni_Sifre':'" + Yeni_Sifre.val() + "','Yeni_Sifre_Tekrar':'" + Yeni_Sifre_Tekrar.val()+"'}",
                            contentType: 'application/json; charset=utf-8',
                            success: function (data) {
                                if (data.d == "") {
                                    İşlem_Mesajı.text("Lütfen Tüm Boşlukları İstenilen Şekilde Doldurunuz")
                                    $('#Şifre_Değiştir_Modal').modal('toggle')
                                    $('#İşlem_Başarılı').modal('show')
                                }
                                else {
                                    İşlem_Mesajı.text("İşlem Başarılı")
                                    $('#Şifre_Değiştir_Modal').modal('toggle')
                                    $('#İşlem_Başarılı').modal('show')
                                }
                               

                            },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                            error: function () {

                                alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                            }
                        });
                    }
                }
                Eski_Sifre.val('')
                Yeni_Sifre.val('')
                Yeni_Sifre_Tekrar.val('')
            })
            var resim = "";
            var Profil_Resmi_Degistir = $('input[id=Profil_Resmi_Degistir]')
            Profil_Resmi_Degistir.click(function () {
                resim = "";
                $('#Profil_Resmi_Degistir_Modal').modal('show')
            })

           
            var Profil_Resmi_Degistir_Buton = $('button[id=Profil_Resmi_Degistir_Buton]')

            if (FileReader.prototype.readAsBinaryString === undefined) {	//Needed for IE
                FileReader.prototype.readAsBinaryString = function (fileData) {
                    var binary = "";
                    var pt = this;
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var bytes = new Uint8Array(reader.result);
                        var length = bytes.byteLength;
                        for (var i = 0; i < length; i++) {
                            binary += String.fromCharCode(bytes[i]);
                        }
                        //pt.result  - readonly so assign content to another property
                        pt.content = binary;
                        $(pt).trigger('onload');
                    }
                    reader.readAsArrayBuffer(fileData);
                }
            }

            var handleFileSelect = function (evt) {
                var files = evt.target.files;
                var file = files[0];
                if (files && file) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var binaryString;// = e.target.result;
                        if (!e) {
                            binaryString = reader.content;
                        }
                        else {
                            binaryString = e.target.result;
                        }
                        resim = "";
                        resim=window.btoa(binaryString);
                        
                    };
                    reader.readAsBinaryString(file);

                }
            };

            if (window.File && window.FileReader && window.FileList && window.Blob) {
                //document.getElementById('filePicker').addEventListener('change', handleFileSelect, false);
                $('input[id=filePicker]').on('change', handleFileSelect);
            } else {
                alert('The File APIs are not fully supported in this browser.');
            }
            Profil_Resmi_Degistir_Buton.click(function () {
                if (resim=="") {
                    İşlem_Mesajı.text("Lütfen Resim Seçiniz")
                    $('#Profil_Resmi_Degistir_Modal').modal('toggle')
                    $('#İşlem_Başarılı').modal('show')
                }
                else {
                    $.ajax({
                        url: 'Profil.aspx/Profil_Resimi_Degistir',
                        dataType: 'json',
                        type: 'POST',
                        data: "{'Resim_Base64': '" +resim + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            if (data.d == "") {
                                İşlem_Mesajı.text("İşlem Başarılı")
                                $('#Profil_Resmi_Degistir_Modal').modal('toggle')
                                $('#İşlem_Başarılı').modal('show')//name="Profil_Resimi"
                                var Profil_Resimi = $('img[name=Profil_Resimi]')
                                Profil_Resimi.attr('src', "data:image/webp;base64," + resim)
                                resim = "";
                            }
                            else {
                                İşlem_Mesajı.text("Lütfen Tüm Boşlukları İstenilen Şekilde Doldurunuz")
                                $('#Profil_Resmi_Degistir_Modal').modal('toggle')
                                $('#İşlem_Başarılı').modal('show')
                                resim = "";
                            }
                        },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });
                }
            })

        })

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                      <label id="İşlem_Mesajı" ></label> 

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                      
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="Profil_Resmi_Degistir_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="İşlem_Başarılı_label">Şifre Değiştirme Penceresi</h4>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                     <label>Profil Resmi Değiştirmek İçin Dosya Seçiniz</label>
                                    <input type="file" id="filePicker" accept="image/x-png, image/jpeg" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Profil_Resmi_Degistir_Buton" class="btn btn-primary">Profil Resmini Reğiştir</button>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="Şifre_Değiştir_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="İşlem_Başarılı_label">Şifre Değiştirme Penceresi</h4>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Eski Şifre</label>
                                <div class="form-group">
                                    <input id="Eski_Sifre" type="password" class="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Yeni Şİfre</label>
                                <div class="form-group">
                                    <input id="Yeni_Sifre" type="password" class="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Yeni Şifre Tekrar</label>
                                <div class="form-group">
                                    <input id="Yeni_Sifre_Tekrar" type="password" class="form-control" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Şifreyi_Değiştir" class="btn btn-primary">Şifreyi Değiştir</button>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="box" name="genel_Box">
                <div class="box-body">
                    <div class="box" name="Profil_Resmi_Box">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-xs-2" style="padding-top: 50px">
                                    <img class="img-circle" src="" name="Profil_Resimi" style="width: 80px;">
                                </div>
                                <div class="col-xs-10" style="margin-top: 10px">
                                   
                                    <div class="box" name="Kullanıcı_Bilgileri">
                                        <div class="box-body">
                                            <div class="box-body table-responsive no-padding">
                                                <table class="table table-hover">
                                                    <tbody>
                                                        <tr>
                                                            <td>Kullanıcı Adı:</td>
                                                            <td name="Kullanıcı_Adı"></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Adı Soyadı:</td>
                                                            <td name="Ad_Soyad"></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Grup:</td>
                                                            <td name="Grup"></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Bölge:</td>
                                                            <td name="Bolge"></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box" name="Şifre_Değiştir">
                        <div class="box-body">
                            <div class="box-body ">
                                <input class="btn btn-block btn-primary" id="Sifre_Degistir" type="button" value="Şifre Değiştir" />
                                <input class="btn btn-block btn-primary" id="Profil_Resmi_Degistir" type="button" value="Profil Resmi Değiştir" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
