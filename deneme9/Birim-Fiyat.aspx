<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Birim-Fiyat.aspx.cs" Inherits="deneme9.Birim_Fiyat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            var İlaçlar = $('div[id=İlaçlar]')
            $.ajax({
                url: 'Birim-Fiyat.aspx/Urunler',
                dataType: 'json',
                type: 'POST',
                async: false,
                data: "{'Şehir_Id': ''}",

                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var parsdata = JSON.parse(data.d)
                    İlaçlar.empty();
                    for (var i = 0; i < parsdata.length; i++) {
                        İlaçlar.append(
                            '<div class="row">' +
                            '<div class="col-lg-12">' +
                            '<div class="box   collapsed-box box-solid">' +
                            '<div class="box-header with-border">' +
                            '<div class="col-xs-1">' +
                            '<img class="img-circle" src="' + parsdata[i].İlaçresim.replace('~', '') + '" style="width: 80px;" />' +
                            '</div>' +
                            '<div class="col-xs-11">' +
                            '<h1 id="İlaç_Adı_txt" class="box-title" style="padding:25px">' + parsdata[i].İlaç_Adı + '</h1>' +
                            '</div>' +
                            '<div class=" box-tools   pull-right">' +
                            '<button type="button" id="deneme" class=" btn-primary no-border" data-widget="collapse" style="font-size: 50px; background-color: #00dcdc">' +
                            '<i class="fa fa-plus"></i>' +
                            '</button>' +
                            '</div>' +
                            '</div>' +
                            '<div class="box-body">' +
                            '<div class="row">' +
                            '<div class="col-xs-4">' +
                            '<label>Güncel İSF</label>' +
                            '<div class="form-group ">' +
                            '<input id="Guncel_Isf"  class="form-control" value="' + parsdata[i].Guncel_ISF+'"  disabled />' +
                            '</div>' +
                            '</div>' +
                            '<div class="col-xs-4">' +
                            '<label>Güncel DSF</label>' +
                            '<div class="form-group ">' +
                            '<input id="Guncel_Dsf"  class="form-control" value="' + parsdata[i].Guncel_DSF +'"  disabled />' +
                            '</div>' +
                            '</div>' +
                            '<div class="col-xs-4">' +
                            '<label>Güncel PSF + KDV</label>' +
                            '<div class="form-group">' +
                            '<input id="KDV_Guncel_PSF"  class="form-control" value="' + parsdata[i].KDV_Guncel_PSF +'"  disabled />' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '<div class="row">' +
                            '<div class="col-xs-4">' +
                            '<label>Adet</label>' +
                            '<div class="form-group has-error">' +
                            '<input id="Adet" type="number" class="form-control" placeholder="10" />' +
                            '</div>' +
                            '</div>' +
                            '<div class="col-xs-4">' +
                            '<label>MF Adet</label>' +
                            '<div class="form-group has-error">' +
                            '<input id="Mf_Adet" type="number" class="form-control" placeholder="5" />' +
                            '</div>' +
                            '</div>' +
                            '<div class="col-xs-4">' +
                            '<label>Toplam Adet</label>' +
                            '<div class="form-group">' +
                            '<input id="Toplam_Adet" type="text" class="form-control" disabled />' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '<div class="row">' +
                            '<div class="col-xs-6">' +
                            '<label>Birim Fiyat Adet</label>' +
                            '<div class="form-group">' +
                            '<input id="Birim_Fiyat" type="text" class="form-control" disabled />' +
                            '</div>' +
                            '</div>' +
                            '<div class="col-xs-6">' +
                            '<label>Satış Fiyatı Adet</label>' +
                            '<div class="form-group">' +
                            '<input id="Satış_Fiyat" type="text" class="form-control" disabled  />' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '<div class="row">' +
                            '<div class="col-xs-6">' +
                            '<label>Birim Fiyat Toplam</label>' +
                            '<div class="form-group">' +
                            '<input id="Birim_Fiyat_Toplam" type="text" class="form-control" disabled />' +
                            '</div>' +
                            '</div>' +
                            '<div class="col-xs-6">' +
                            '<label>Satış Fiyatı Toplam</label>' +
                            '<div class="form-group">' +
                            '<input id="Satış_Fiyat_Toplam" type="text" class="form-control" disabled  />' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '<div class="box-footer">' +
                            '<div class="row">' +
                            '<div class="col-xs-12">' +
                            '<div class="form-group">' +
                            '<a id="Hesapla" Ilaç_Id="' + parsdata[i].İlaç_Id + '" Guncel_Isf="' + parsdata[i].Guncel_ISF + '" Guncel_Dsf="' + parsdata[i].Guncel_DSF + '" KDV_Guncel_PSF="' + parsdata[i].KDV_Guncel_PSF+'"  class="btn btn-info pull-right">Hesapla</a>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>'
                        );
                    }
                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });
            var Hesapla = $('a[id=Hesapla]');
            (function ($) {
                $.fn.inputFilter = function (inputFilter) {
                    return this.on("input keydown keyup mousedown mouseup select contextmenu drop", function () {
                        if (inputFilter(this.value)) {
                            this.oldValue = this.value;
                            this.oldSelectionStart = this.selectionStart;
                            this.oldSelectionEnd = this.selectionEnd;
                        } else if (this.hasOwnProperty("oldValue")) {
                            this.value = this.oldValue;
                            this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
                        }
                        else {
                            this.value = "";
                        }
                    });
                };
            }(jQuery));

            $("#Adet, #Mf_Adet").inputFilter(function (value) {
                return /^\d*$/.test(value);
            });

            $("#Adet, #Mf_Adet").on("input keydown keyup mousedown mouseup select contextmenu drop", function () {

                var Genel_Div = $(this).parent().parent().parent().parent().parent().parent().parent()
            
                var urun_fiyat = Genel_Div.find('a[id=Hesapla]').attr('guncel_dsf')//form-group has-error
                var Adet = Genel_Div.find('input[id=Adet]')
                var Mf_Adet = Genel_Div.find('input[id=Mf_Adet]')
                var Toplam_Adet = Genel_Div.find('input[id=Toplam_Adet]')
                var Birim_Fiyat = Genel_Div.find('input[id=Birim_Fiyat]')
                var Satış_Fiyat = Genel_Div.find('input[id=Satış_Fiyat]')
                var Birim_Fiyat_Toplam = Genel_Div.find('input[id=Birim_Fiyat_Toplam]')
                var Satış_Fiyat_Toplam = Genel_Div.find('input[id=Satış_Fiyat_Toplam]')

                var Adet__Filt = "";
                var Mf_Adet_Flit = "";
                var gondersinmi_1 = false;
                var gondersinmi_2 = false;
                if (Adet.val() == "" || Adet.val() == undefined) {
                    Adet.parent().attr('class', 'form-group has-error')

                }
                else {
                    Adet__Filt = Adet.val()
                    Adet.parent().attr('class', 'form-group')
                    gondersinmi_1 = true;
                }
                if (Mf_Adet.val() == "" || Mf_Adet.val() == undefined) {

                    Mf_Adet.parent().attr('class', 'form-group has-error')
                }
                else {
                    Mf_Adet_Flit = Mf_Adet.val()
                    Mf_Adet.parent().attr('class', 'form-group')
                    gondersinmi_2 = true;
                }

                if (gondersinmi_1 == true && gondersinmi_2 == true) {

                    $.ajax({
                        url: 'Siparis-Olustur.aspx/Birim_Fiyat_Hesapla',
                        type: 'POST',
                        data: "{'Guncel_DSF': '" + urun_fiyat + "','Adet':'" + Adet__Filt + "','Mf_Adet':'" + Mf_Adet_Flit + "'}",
                        async: false,
                        global: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            
                            var temp = JSON.parse(data.d)
                            Toplam_Adet.val(parseInt(Adet__Filt) + parseInt(Mf_Adet_Flit))
                            Birim_Fiyat.val(temp.Birim_Fiyat)
                            Satış_Fiyat.val(urun_fiyat)
                            Birim_Fiyat_Toplam.val(temp.Birim_Fiyatı_Toplam)
                            Satış_Fiyat_Toplam.val(temp.Satış_Fiyatı_Toplam)


                        },
                        error: function () {

                            alert('Talep esnasında sorun oluştu.Yeniden deneyin');

                        }
                    });

                }


            })

            Hesapla.click(function () {
                var Genel_Div = $(this).parent().parent().parent().parent().parent().parent().parent()
             
                var urun_fiyat = $(this).attr('guncel_dsf')
                var Adet = Genel_Div.find('input[id=Adet]').val()
                var Mf_Adet = Genel_Div.find('input[id=Mf_Adet]').val()
                var Toplam_Adet = Genel_Div.find('input[id=Toplam_Adet]')
                var Birim_Fiyat = Genel_Div.find('input[id=Birim_Fiyat]')
                var Satış_Fiyat = Genel_Div.find('input[id=Satış_Fiyat]')
                var Birim_Fiyat_Toplam = Genel_Div.find('input[id=Birim_Fiyat_Toplam]')
                var Satış_Fiyat_Toplam = Genel_Div.find('input[id=Satış_Fiyat_Toplam]')



                var Adet__Filt = "";
                var Mf_Adet_Flit = "";
                var gondersinmi_1 = false;
                var gondersinmi_2 = false;
                if (Adet.val() == "" || Adet.val() == undefined) {
                    Adet.parent().attr('class', 'form-group has-error')

                }
                else {
                    Adet__Filt = Adet.val()
                    Adet.parent().attr('class', 'form-group')
                    gondersinmi_1 = true;
                }
                if (Mf_Adet.val() == "" || Mf_Adet.val() == undefined) {

                    Mf_Adet.parent().attr('class', 'form-group has-error')
                }
                else {
                    Mf_Adet_Flit = Mf_Adet.val()
                    Mf_Adet.parent().attr('class', 'form-group')
                    gondersinmi_2 = true;
                }

                if (gondersinmi_1 == true && gondersinmi_2 == true) {

                    $.ajax({
                        url: 'Siparis-Olustur.aspx/Birim_Fiyat_Hesapla',
                        type: 'POST',
                        data: "{'Guncel_DSF': '" + urun_fiyat + "','Adet':'" + Adet__Filt + "','Mf_Adet':'" + Mf_Adet_Flit + "'}",
                        async: false,
                        global: false,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            var temp = JSON.parse(data.d)
                            Toplam_Adet.val(parseInt(Adet__Filt) + parseInt(Mf_Adet_Flit))
                            Birim_Fiyat.val(temp.Birim_Fiyat___)
                            Satış_Fiyat.val(temp.Satış_Fiyat)
                            Birim_Fiyat_Toplam.val(temp.Birim_Fiyatı_Toplam)
                            Satış_Fiyat_Toplam.val(temp.Satış_Fiyatı_Toplam)


                        },
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
    <div id="İlaçlar">
    </div>
</asp:Content>
