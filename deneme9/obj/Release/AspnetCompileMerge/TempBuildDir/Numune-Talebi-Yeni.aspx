<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Numune-Talebi-Yeni.aspx.cs" Inherits="deneme9.Numune_Talebi_Yeni" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.11.2/jquery.mask.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/5.0.7-beta.29/jquery.inputmask.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('[data-mask]').inputmask('0(599)-999-9999', { autoclear: true })

            var Şehir_Listesi_Normal = $('select[id=Şehir_Listesi_Normal]');
            var Brick_Listesi_Normal = $('select[id=Brick_Listesi_Normal]');
            var Eczane_Adı_Normal = $('select[id=Eczane_Adı_Normal]');



            $.ajax({
                url: 'Eczane-Ara.aspx/Şehir_Listesi', //doktorları listelerken tersten listele 
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'parametre': '0'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    Şehir_Listesi_Normal.empty();
                    Şehir_Listesi_Normal.append("<option value='0'>-->> Lütfen Şehir Seçiniz <<--</option>")

                    var parsdata = JSON.parse(data.d)

                    for (var i = 0; i < parsdata.length; i++) {
                        Şehir_Listesi_Normal.append("<option value='" + parsdata[i].Şehir_Id + "'>" + parsdata[i].Şehir_Adı + "</option>");
                    }
                },
                error: function () {

                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                }
            });
            Şehir_Listesi_Normal.change(function () {

                $.ajax({
                    url: 'Eczane-Ara.aspx/Brick_Listesi', //doktorları listelerken tersten listele 
                    dataType: 'json',
                    type: 'POST',
                    data: "{'Şehir_Id': '" + $(this).find('option:selected').attr("value") + "'}",//liste cinsini de yolla o gördüğün 0 liste cinsi
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        Brick_Listesi_Normal.empty();
                        Brick_Listesi_Normal.append("<option value'0'>-->> Lütfen İlçe Seçiniz <<--</option>");
                        var parsdata = JSON.parse(data.d)

                        for (var i = 0; i < parsdata.length; i++) {
                            Brick_Listesi_Normal.append("<option value='" + parsdata[i].Brick_Id + "'>" + parsdata[i].Brick_Adı + "</option>");
                        }
                        if (Şehir_Listesi_Normal.parent().children().find($("select option:first-child")).html() == "--&gt;&gt; Lütfen Şehir Seçiniz &lt;&lt;--") {
                            Şehir_Listesi_Normal.parent().children().find($("select option:first-child")).remove();
                        }
                    },
                    error: function () {

                        alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                    }
                });
            });
            $.ajax({
                url: 'Numune-Talebi-Yeni.aspx/Koli_Ad_Getir', //doktorları listelerken tersten listele
                dataType: 'json',
                type: 'POST',
                async: false,
                /*data: "{'Eczane_Listesi': '{Deneme:" + JSON.stringify(Eczane_Liste) + "}'}",*/
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var temp = JSON.parse(data.d)
                    $('#Koliler').empty()
                    for (var i = 0; i < temp.length; i++) {
                        var variable = '' +
                            '<div class="col-md-6">' +
                            '                            <div class="box">' +
                            '                                <div class=" box-header">' + temp[i].Koli_Ad + '</div>' +
                            '                                <div class="box-body">' +
                            '                                    <div class="row">' +
                            '                                        <div class="col-md-12">' +
                            '                                            <div class="form-group" id="Koli_İçi_' + temp[i].ID + '">' +
                            '                                                </div>' +
                            '                                            </div>' +
                            '                                        </div>' +
                            '                                    </div>' +
                            '                                </div>' +
                            '                            </div>' +
                            '                        </div>' +
                            '';

                        $('#Koliler').append(variable)

                    }


                },
                error: function () {

                    Swal.fire({
                        title: 'Hata!',
                        text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                        icon: 'error',
                        confirmButtonText: 'Kapat'
                    })

                }
            });

            $.ajax({
                url: 'Numune-Talebi-Yeni.aspx/Koli_Urun_Getir', //doktorları listelerken tersten listele
                dataType: 'json',
                type: 'POST',
                async: false,
                /*data: "{'Eczane_Listesi': '{Deneme:" + JSON.stringify(Eczane_Liste) + "}'}",*/
                contentType: 'application/json; charset=utf-8',
                success: function (data) {

                    var temp = JSON.parse(data.d)
                    console.log(temp)
                    for (var i = 0; i < temp.length; i++) {
                        var variable = '' +
                            ' <div class="checkbox">' +
                            '                                                    <label style="padding-top: 16px; padding-left: 25px;">' +
                            '                                                        <input type="checkbox" Koli_ID="' + temp[i].Koli_ID + '" Urun_Id="' + temp[i].ID + '" Urun_Ad="' + temp[i].Urun_Ad + '" style="top: 1.2rem; width: 1.85rem; height: 1.85rem;" />' +
                            '                                                        ' + temp[i].Urun_Ad
                        '                                                    </label>' +
                            '                                                </div>' +
                            '';

                        $('#Koli_İçi_' + temp[i].Koli_ID).append(variable)

                    }

                    //$('input[type=checkbox]').change(function () {

                    //    if ($(this).is(':checked')) {
                    //        $('input[type=checkbox][Koli_ID != ' + $(this).attr('Koli_ID') + ']').attr('disabled', 'true')
                    //        $('input[type=checkbox][Koli_ID != ' + $(this).attr('Koli_ID') + ']').parent().parent().parent().attr('class', 'form-group has-error')
                    //        $(this)
                    //    }
                    //    else {
                    //        if (!$('input[type=checkbox][Koli_ID = ' + $(this).attr('Koli_ID') + ']').is(':checked')) {
                    //            $('input[type=checkbox][Koli_ID != ' + $(this).attr('Koli_ID') + ']').parent().parent().parent().attr('class', 'form-group')
                    //            $('input[type=checkbox][Koli_ID != ' + $(this).attr('Koli_ID') + ']').removeAttr('disabled')
                    //        }
                         
                    //    }

                    //})


                },
                error: function () {

                    Swal.fire({
                        title: 'Hata!',
                        text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                        icon: 'error',
                        confirmButtonText: 'Kapat'
                    })

                }
            });
            $('#Teslimat_Adresi').val("")
            $('#Kullanıcı_Notu').val("")
            $('#siparişi_Oluştur').click(function () {
                console.log($('#Cep_Tel').val().replace('-', '   ').replace('(', '').replace(')', '').replace('-', '').replace('_', ''))

                var Urun_Liste = [];

                $('input[type*=checkbox]').each(function () {


                    if ($(this).is(':checked')) {
                        console.log($(this).attr('Urun_Id'))
                        console.log($(this).attr('Urun_Ad'))

                        var Urun_Adı_Class = {
                            Urun_ID_: $(this).attr('Urun_Id'),
                            Urun_Adı_: $(this).attr('Urun_Ad')
                        }
                        Urun_Liste.push(Urun_Adı_Class)
                    }
                })

                if (Urun_Liste.length < 1) {
                    Swal.fire({
                        title: 'Hata!',
                        text: 'Lütfen Urun Seçiniz',
                        icon: 'error',
                        confirmButtonText: 'Kapat'
                    })
                }
                if ($('#Şehir_Listesi_Normal').find('option:selected').attr('value') == "0") {
                    Swal.fire({
                        title: 'Hata!',
                        text: 'Lütfen Teslimat İli Seçiniz',
                        icon: 'error',
                        confirmButtonText: 'Kapat'
                    })
                }
                if ($('#Brick_Listesi_Normal').find('option:selected').attr('value') == "0" || $('#Brick_Listesi_Normal').find('option:selected').val() == "undefined") {
                    Swal.fire({
                        title: 'Hata!',
                        text: 'Lütfen Teslimat İlçesi Seçiniz',
                        icon: 'error',
                        confirmButtonText: 'Kapat'
                    })
                }


                $.ajax({
                    url: 'Numune-Talebi-Yeni.aspx/Talep_Oluştur',
                    dataType: 'json',
                    type: 'POST',
                    async: false,

                    data: "{" +
                        "'Urunler':'{Urun_Liste:" + JSON.stringify(Urun_Liste) + "}'," +
                        "'İl':'" + $('#Şehir_Listesi_Normal').find('option:selected').attr('value') + "'," +
                        "'İlçe':'" + $('#Brick_Listesi_Normal').find('option:selected').attr('value') + "'," +
                        "'İlçe':'" + $('#Brick_Listesi_Normal').find('option:selected').attr('value') + "'," +
                        "'Kullanıcı_Notu':'" + $('#Kullanıcı_Notu').val() + "'," +
                        "'İletişim_Tel':'" + $('#Cep_Tel').val().replace('-', '   ').replace('(', '').replace(')', '').replace('-', '').replace('_', '') + "'," +
                        "'Teslimat_Adresi':'" + $('#Teslimat_Adresi').val() + "'," +
                        "'Alıcı_Adı_Soyadı':'" + $('#Alıcı_Adı_Soyadı').val() + "'" +
                        "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                      
                        var temp = JSON.parse(data.d);
                        Swal.fire({
                            title: 'Başarılı!',
                            text: 'İşlem Başarı İle Kaydedildi',
                            icon: 'success',
                            confirmButtonText: 'Kapat'
                        })
                        Urun_Liste = []
                        Listeyi_Doldur_Arama()
                        $('#Brick_Listesi_Normal').empty()
                        $('#Cep_Tel').val("")
                        $('#Teslimat_Adresi').html("")
                    },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                    error: function () {
                        Swal.fire({
                            title: 'Hata!',
                            text: 'Lütfen Tüm Alanları Doldurunuz',
                            icon: 'error',
                            confirmButtonText: 'Kapat'
                        })
                    }
                });


            })



            Listeyi_Doldur_Arama()


            function Listeyi_Doldur_Arama() {



                var Liste_ = [];



                $.ajax({
                    url: 'Numune-Talebi-Yeni.aspx/Talep_Liste_Doldur', //doktorları listelerken tersten listele
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    /*data: "{'Eczane_Listesi': '{Deneme:" + JSON.stringify(Eczane_Liste) + "}'}",*/
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)
                        console.log(temp)
                        for (var i = 0; i < temp.length; i++) {

                            var Talep_Class = {
                                Oluşturulma_Tarihi: temp[i].Oluşturulma_Tarihi,
                                Kullanıcı_Ad_Soyad: temp[i].Kullanıcı_Ad_Soyad,
                                Alıcı_Adı_Soyadı: temp[i].Alıcı_Adı_Soyadı,
                                İl: temp[i].İl,
                                İlçe: temp[i].İlçe,
                                Teslimat_Adresi: temp[i].Teslimat_Adresi,
                                Urun_ID_: temp[i].Oluşturulma_Tarihi,
                                Durum: temp[i].Durum,
                                Genel_ID: temp[i].Genel_ID,
                                Kullanıcı_Notu: temp[i].Kullanıcı_Notu,
                                Merkez_Notu: temp[i].Merkez_Notu,
                            }
                            Liste_.push(Talep_Class)
                        }


                    },
                    error: function () {

                        Swal.fire({
                            title: 'Hata!',
                            text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                            icon: 'error',
                            confirmButtonText: 'Kapat'
                        })

                    }
                });


                $('#Tablo_Arama_Div').empty();

                $('#Tablo_Arama_Div').append('<table id="Arama_Table" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +

                    '                                            <th>Oluşturulma Tarihi</th>' +
                    '                                            <th>Oluşturan Kullanıcı</th>' +
                    '                                            <th>Alıcı Adı Soyadı</th>' +
                    '                                            <th>Teslimat İli</th>' +
                    '                                            <th>Teslimat İlçesi</th>' +
                    '                                            <th>Teslimat Adresi</th>' +
                    '                                            <th>Durum</th>' +

                    '                                            <th>Kargo Takip No</th>' +
                    '                                            <th>Kullanıcı Notu</th>' +
                    '                                            <th>Merkez Notu</th>' +
                    '                                            <th>Ürünleri Gör</th>' +
                    '                                            <th>Sil</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Arama_Body">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );




                if (Liste_.length > 0) {
                    var Tbody = $('tbody[id=Arama_Body]')

                    for (var i = 0; i < Liste_.length; i++) {

                        var Durum_Label = '';
                        var silme = "";
                        if (Liste_[i].Durum == "0") {
                            Durum_Label = '<span class="label label-warning">Beklemede</span>'
                        }
                        if (Liste_[i].Durum == "1") {
                            Durum_Label = '<span class="label label-info">İşleme Alındı</span>'

                        }
                        if (Liste_[i].Durum == "2") {
                            Durum_Label = '<span class="label label-info">Kargoya Verildi</span>'

                        }
                        if (Liste_[i].Durum == "3") {
                            Durum_Label = '<span class="label label-success">Kargo Ulaştı</span>'
                        }
                        if (Liste_[i].Durum == "4") {
                            Durum_Label = '<span class="label label-danger">Reddedildi</span>'
                        }

                        if (Liste_[i].Durum == "0") {
                            silme = '<a value="' + Liste_[i].Genel_ID + '" id="Talep_Sil"><i class="fa fa fa-trash"></i></a>'
                        }

                        Tbody.append(
                            '<tr>' +
                            '<td>' + Liste_[i].Oluşturulma_Tarihi + '</td>' +
                            '<td>' + Liste_[i].Kullanıcı_Ad_Soyad + '</td>' +
                            '<td>' + Liste_[i].Alıcı_Adı_Soyadı + '</td>' +
                            '<td>' + Liste_[i].İl + '</td>' +
                            '<td>' + Liste_[i].İlçe + '</td>' +
                            '<td>' + Liste_[i].Teslimat_Adresi + '</td>' +
                            '<td>' + Durum_Label + '</td>' +
                            '<td>' + Liste_[i].Kargo_Takip_No + '</td>' +
                            '<td>' + Liste_[i].Kullanıcı_Notu + '</td>' +
                            '<td>' + Liste_[i].Merkez_Notu + '</td>' +
                            '<td style="text-align: center;">' + '<a value="' + Liste_[i].Genel_ID + '" id="Urunleri_Gor"><i class="fa fa fa-search"></i></a>' + '</td>' +
                            '<td style="text-align: center;" >' + silme + '</td>' +
                            '</tr>'
                        )
                    }


                }



                $('#Arama_Table').dataTable({
                    "lengthMenu": [5, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },
                    scrollX:true
                });


                $('a[id=Urunleri_Gor]').click(function () {
                    $.ajax({
                        url: 'Numune-Talebi-Yeni.aspx/Talepteki_Urunleri_Getir', //doktorları listelerken tersten listele
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Talep_Genel_Id': '" + $(this).attr('value') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            var temp = JSON.parse(data.d)
                            $('#Urun_Listesi_Body').empty()
                            for (var i = 0; i < temp.length; i++) {

                                $('#Urun_Listesi_Body').append('<tr><td style="text-align: center;">' + temp[i].Urun_Ad + '</td></tr>')
                                
                            }
                            $('#Urun_Listesi').modal('show')


                        },
                        error: function () {

                            Swal.fire({
                                title: 'Hata!',
                                text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                icon: 'error',
                                confirmButtonText: 'Kapat'
                            })

                        }
                    });


                })
                $('a[id=Talep_Sil]').click(function () {
                    $.ajax({
                        url: 'Numune-Talebi-Yeni.aspx/Talep_Sil', //doktorları listelerken tersten listele
                        dataType: 'json',
                        type: 'POST',
                        async: false,
                        data: "{'Talep_Genel_Id': '" + $(this).attr('value') + "'}",
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {

                            var temp = JSON.parse(data.d)
                            Swal.fire({
                                title: 'Başarılı!',
                                text: 'İşlem Başarı İle Kaydedildi',
                                icon: 'success',
                                confirmButtonText: 'Kapat'
                            })
                            Listeyi_Doldur_Arama()

                        },
                        error: function () {

                            Swal.fire({
                                title: 'Hata!',
                                text: 'Talep esnasında sorun oluştu.Yeniden deneyin',
                                icon: 'error',
                                confirmButtonText: 'Kapat'
                            })

                        }
                    });
                })

                

            }


        })
    </script>

    <style>
        .checkbox-lg .custom-control-label::before,
        .checkbox-lg .custom-control-label::after {
            top: .8rem;
            width: 1.55rem;
            height: 1.55rem;
        }

        .checkbox-lg .custom-control-label {
            padding-top: 13px;
            padding-left: 6px;
        }


        .checkbox-xl .custom-control-label::before,
        .checkbox-xl .custom-control-label::after {
            top: 1.2rem;
            width: 1.85rem;
            height: 1.85rem;
        }

        .checkbox-xl .custom-control-label {
            padding-top: 23px;
            padding-left: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="modal fade" id="Urun_Listesi" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title" id="İşlem_Başarılı_label">Talep Edilen Ürünler</h4>

                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th style="text-align: center;">Urun Adı</th>
                                    </tr>
                                </thead>
                                <tbody id="Urun_Listesi_Body">
                                  
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-body">
                    <div class="row" id="Koliler">
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Alıcı Adı Soyadı:</label>
                                <input id="Alıcı_Adı_Soyadı" class="form-control" type="text" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>İletişim Numarası</label>
                                <input id="Cep_Tel" type="text" class="form-control form-control-sm" data-inputmask='' data-mask="" placeholder="0(5__) ___-__-__" inputmode="text" />
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>Şehir</label>
                                <select id="Şehir_Listesi_Normal" class="form-control"></select>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label>İlçe</label>
                                <select id="Brick_Listesi_Normal" class="form-control"></select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label>Teslimat Adresi</label>
                            <div class="form-group">
                                <textarea class="form-control" id="Teslimat_Adresi" rows="5">
                                </textarea>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label>Kullanıcı Notu</label>
                            <div class="form-group">
                                <textarea class="form-control" id="Kullanıcı_Notu" rows="3">
                                </textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <input type="button" class="btn btn-info pull-right" id="siparişi_Oluştur" value="Talebi  Oluştur" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="box">
                <div class="box-header">Önceki Talepler</div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div id="Tablo_Arama_Div"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

