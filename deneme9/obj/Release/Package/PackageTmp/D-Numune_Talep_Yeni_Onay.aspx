<%@ Page Title="" Language="C#" MasterPageFile="~/Dp.Master" AutoEventWireup="true" CodeBehind="D-Numune_Talep_Yeni_Onay.aspx.cs" Inherits="deneme9.D_Numune_Talep_Yeni_Onay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.2.0/html2canvas.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            document.cookie = "username=John Doe";
            let cokkie = document.cookie;
            console.log(cokkie)
            var TextBox1 = $('input[id*=TextBox1]')
            var TextBox2 = $('input[id*=TextBox2]')
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
            TextBox2.attr('value', formatDate(d));
            var d = new Date(x.getFullYear(), x.getMonth(), 1);
            TextBox1.attr('value', formatDate(d));


            $('#cal_set').click(function () {
                Listeyi_Doldur_Arama()
            })

            Listeyi_Doldur_Arama()


            function Listeyi_Doldur_Arama() {



                var Liste_ = [];



                $.ajax({
                    url: 'D-Numune_Talep_Yeni_Onay.aspx/Talep_Liste_Doldur', //doktorları listelerken tersten listele
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'Bas_Tar': '" + TextBox1.val() + "','Bit_Tar':'" + TextBox2.val() + "'}",
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
                    '                                            <th>Yazdır</th>' +
                    '                                            <th>Ürünleri Gör</th>' +
                    '                                            <th>Sil</th>' +
                    '                                            <th>Durumu/Not/Kargo Takip No Güncelle</th>' +
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
                            silme = '<a style=" font-size: 40px;" value="' + Liste_[i].Genel_ID + '" id="Talep_Sil"><i class="fa fa fa-trash"></i></a>'
                        }
                        //fa-pencil-square
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
                            '<td style="text-align: center;">' + '<a style=" font-size: 40px;" Merkez_Notu="' + Liste_[i].Merkez_Notu + '" Teslimat_İlçe="' + Liste_[i].İlçe + '" Teslimat_İl="' + Liste_[i].İl + '" Genel_ID="' + Liste_[i].Genel_ID + '" Oluşturan_Kullanıcı="' + Liste_[i].Kullanıcı_Ad_Soyad + '" Alıcı_Adı_Soyadı="' + Liste_[i].Alıcı_Adı_Soyadı + '" Teslimat_Adresi="' + Liste_[i].Teslimat_Adresi + '" value="' + Liste_[i].Genel_ID + '" id="Yazdır"><i class="fa fa fa-print"></i></a>' + '</td>' +
                            '<td style="text-align: center;">' + '<a style=" font-size: 40px;" value="' + Liste_[i].Genel_ID + '" id="Urunleri_Gor"><i class="fa fa fa-search"></i></a>' + '</td>' +
                            '<td style="text-align: center;" >' + silme + '</td>' +
                            '<td style="text-align: center;">' + '<a style=" font-size: 40px;" value="' + Liste_[i].Genel_ID + '" id="Durumu_Güncelle"><i class="fa fa fa-pencil-square"></i></a>' + '</td>' +
                            '</tr>'
                        )
                    }


                }



                $('#Arama_Table').dataTable({
                    "lengthMenu": [5, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },
                    scrollX: true
                });

                $('#Yazdır').click(function () {

                    $('#Yazdır_Özellikleri').modal('show');
                    $('#Yazdır___').attr('merkez_notu', $(this).attr('merkez_notu'))
                    $('#Yazdır___').attr('teslimat_İlçe', $(this).attr('teslimat_İlçe'))
                    $('#Yazdır___').attr('teslimat_İl', $(this).attr('teslimat_İl'))
                    $('#Yazdır___').attr('genel_id', $(this).attr('genel_id'))
                    $('#Yazdır___').attr('oluşturan_kullanıcı', $(this).attr('oluşturan_kullanıcı'))
                    $('#Yazdır___').attr('alıcı_adı_soyadı', $(this).attr('alıcı_adı_soyadı'))
                    $('#Yazdır___').attr('teslimat_adresi', $(this).attr('teslimat_adresi'))
                    $('#Yazdır___').attr('value', $(this).attr('value'))

                })
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

                $('#Durumu_Güncelle').click(function () {
                    $('#Durum_Değiştir_Modal').modal('show')
                    $('#Numune_Talebi_Durum_Güncelle').attr('value', $(this).attr('value'))

                })



            }

            $('#Numune_Talebi_Durum_Güncelle').click(function () {
                $.ajax({
                    url: 'D-Numune_Talep_Yeni_Onay.aspx/Durum_Güncelle', //doktorları listelerken tersten listele
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'Talep_Genel_Id': '" + $(this).attr('value') + "','Durum':'" + $('#İletim_Durmu ').find('option:selected').attr('value') + "','Merkez_Notu':'" + $('#Sipariş_Onay_Notu').val() + "','Kargo_Takip_No':'" + $('#Kargo_Takip_No').val() + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)
                        Swal.fire({
                            title: 'Başarılı!',
                            text: 'İşlem Başarı İle Kaydedildi',
                            icon: 'success',
                            confirmButtonText: 'Kapat'
                        })
                        $('#Durum_Değiştir_Modal').modal('hide')
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
            $('#Yazdır___').click(function () {
                console.log($('Sayfa_Şekili').find('option:selected').attr('value'))
                var ürünler = [
                ]
                $.ajax({
                    url: 'Numune-Talebi-Yeni.aspx/Talepteki_Urunleri_Getir', //doktorları listelerken tersten listele
                    dataType: 'json',
                    type: 'POST',
                    async: false,
                    data: "{'Talep_Genel_Id': '" + $(this).attr('value') + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {

                        var temp = JSON.parse(data.d)
                        var y = [
                            { text: 'Ürünler', alignment: 'center', },
                        ]
                        ürünler.push(y)
                        for (var i = 0; i < temp.length; i++) {
                            var x = [
                                { text: temp[i].Urun_Ad, alignment: 'left', },
                            ]
                            ürünler.push(x)
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
                var Merkez_Notu;

                if ($(this).attr('Merkez_Notu') != "") {
                    Merkez_Notu = { text: 'Merkez Notu:' + $(this).attr('Merkez_Notu') }
                }

                var Yol_İzinli = {
                    pageSize: {
                        width: parseInt($('#Genişlik').val()),
                        height: parseInt($('#Yükseklik').val()),
                    },
                    pageOrientation: $('Sayfa_Şekili').find('option:selected').attr('value'),
                    content: [

                        {
                            table: {

                                widths: ['*', '*'],

                                body: [
                                    [
                                        [[{ text: 'Gönderen:' }, { text: 'Edis Pharma İlaç', fontSize: 18, }]],
                                        [[{ text: 'Alıcı : ' + $(this).attr('Alıcı_Adı_Soyadı') }, { text: 'Adres Bilgisi : ' + $(this).attr('Teslimat_Adresi'), fontSize: 18, }
                                            , { text: $(this).attr('Teslimat_İlçe') + '/' + $(this).attr('Teslimat_İl'), fontSize: 9, alignment: 'right' }
                                        ]],
                                    ]
                                ]
                            }//$(this).attr('Teslimat_İlçe') + '/' + $(this).attr('Teslimat_İl')
                        },
                        {
                            margin: [5, 20, 10, 20],
                            layout: 'lightHorizontalLines',
                            table: {

                                widths: ['*'],
                                headerRows: 1,
                                body: ürünler
                            }
                        },
                        { text: 'Oluşturan Kullanıcı :' + $(this).attr('Oluşturan_Kullanıcı') },
                        { text: 'ID:' + $(this).attr('Genel_Id') },
                        Merkez_Notu

                    ],



                }
                pdfMake.createPdf(Yol_İzinli).print();

            })
            $("#Yükseklik").maskMoney();
            $("#Genişlik").maskMoney();
        })
    </script>
    <script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-maskmoney/3.0.2/jquery.maskMoney.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="modal fade" id="Yazdır_Özellikleri" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title" id="Yazdır_Özellikleri_Title">Yazdırma Seçenekleri</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>Gönderen Bilgileri</label>
                                    <input id="Gönderen_Bilgileri" type="text" class="form-control form-control-sm" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>Alıcı Bilgileri</label>
                                    <input id="Alıcı_Bilgileri" type="text" class="form-control form-control-sm" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>Yükseklik</label>
                                    <input id="Yükseklik" data-thousands="" data-decimal="."
                                                class="form-control form-control" type="text"
                                                placeholder="Yükseklik"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>Genişlik</label>
                                     <input id="Genişlik" data-thousands="" data-decimal="."
                                                class="form-control form-control" type="text"
                                                placeholder="Genişlik"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Sayfa_Şekili" class="form-control">
                                        <option value="portrait">portrait</option>
                                        <option value="landscape">landscape</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select id="Yazdırma_Seçeneği" class="form-control">
                                        <option value="0">İkisinide Yazdır</option>
                                        <option value="1">Gönderici Alıcı Bilgileri Yazdır</option>
                                        <option value="2">Ürünleri Yazdır</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                         
                        <%-- <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İletim Durumu Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select name="İletim_Durumu_Select" id="İletim_Durmu" class="form-control">
                                        <option value="0">Güncelleme Bekleniyor</option>
                                        <option value="1">İşleme Alındı</option>
                                        <option value="2">Kargoya Verildi</option>
                                        <option value="3">Kargo Ulaştı</option>
                                        <option value="4">Reddedildi</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12" style="padding-top: 40px;">
                                <label>Merkez Notu</label>
                                <textarea class="form-control" rows="4" id="Sipariş_Onay_Notu" placeholder="Merkez Notu"></textarea>
                            </div>
                            <div class="col-xs-12" style="padding-top: 40px;">
                                <label>Kargo Takip No</label>
                                <input class="form-control" id="Kargo_Takip_No" type="text" />
                            </div>
                        </div>--%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Yazdır___" class="btn btn-primary">Yazdır</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="Durum_Değiştir_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="vertical-alignment-helper">
            <div class="modal-dialog vertical-align-center">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>

                        </button>
                        <h4 class="modal-title" id="myModalLabel">Talep Durumu Güncelle</h4>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <label>Lütfen İletim Durumu Seçiniz</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <select name="İletim_Durumu_Select" id="İletim_Durmu" class="form-control">
                                        <option value="0">Güncelleme Bekleniyor</option>
                                        <option value="1">İşleme Alındı</option>
                                        <option value="2">Kargoya Verildi</option>
                                        <option value="3">Kargo Ulaştı</option>
                                        <option value="4">Reddedildi</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12" style="padding-top: 40px;">
                                <label>Merkez Notu</label>
                                <textarea class="form-control" rows="4" id="Sipariş_Onay_Notu" placeholder="Merkez Notu"></textarea>
                            </div>
                            <div class="col-xs-12" style="padding-top: 40px;">
                                <label>Kargo Takip No</label>
                                <input class="form-control" id="Kargo_Takip_No" type="text" />
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Kapat</button>
                        <button type="button" id="Numune_Talebi_Durum_Güncelle" class="btn btn-primary">Güncelle</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
                <div class="box-header">Tüm Talepler</div>
                <div class="box-body">
                    <div class="row">
                        <div class="col-xs-5 ">
                            <div class="form-group">
                                <input id="TextBox1" class="form-control" type="date" />
                            </div>
                        </div>
                        <div class="col-xs-5 ">
                            <div class="form-group">
                                <input id="TextBox2" class="form-control" type="date" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-2 ">
                                <div class="form-group">
                                    <input id="cal_set" type="button" class="btn btn-block btn-info" value="SET" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div id="Tablo_Arama_Div"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
