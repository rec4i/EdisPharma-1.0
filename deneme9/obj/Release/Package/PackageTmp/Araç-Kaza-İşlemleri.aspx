<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Araç-Kaza-İşlemleri.aspx.cs" Inherits="deneme9.Araç_Kaza_İşlemleri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .preview-images-zone {
            width: 100%;
            border: 1px solid #ddd;
            min-height: 180px;
            display: flex;
            padding: 5px 5px 0px 5px;
            position: relative;
            overflow: auto;
        }

            .preview-images-zone > .preview-image:first-child {
                height: 10%;
                width: 10%;
                position: relative;
                margin-right: 5px;
            }

            .preview-images-zone > .preview-image {
                height: 10%;
                width: 10%;
                position: relative;
                margin-right: 5px;
                float: left;
                margin-bottom: 5px;
            }

                .preview-images-zone > .preview-image > .image-zone {
                    width: 100%;
                    height: 100%;
                }

                    .preview-images-zone > .preview-image > .image-zone > img {
                        width: 100%;
                        height: 100%;
                    }

                .preview-images-zone > .preview-image > .tools-edit-image {
                    position: absolute;
                    z-index: 100;
                    color: #fff;
                    bottom: 0;
                    width: 100%;
                    text-align: center;
                    margin-bottom: 10px;
                    display: none;
                }

                .preview-images-zone > .preview-image > .image-cancel {
                    font-size: 18px;
                    position: absolute;
                    top: 0;
                    right: 0;
                    font-weight: bold;
                    margin-right: 10px;
                    cursor: pointer;
                    display: none;
                    z-index: 100;
                }

        .preview-image:hover > .image-zone {
            cursor: move;
            opacity: .5;
        }

        .preview-image:hover > .tools-edit-image,
        .preview-image:hover > .image-cancel {
            display: block;
        }

        .ui-sortable-helper {
            width: 90px !important;
            height: 90px !important;
        }
    </style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/compressorjs/1.0.7/compressor.min.js"></script>


    <script type="text/javascript">

        $(document).ready(function () {
            //#region Lastik_Değişimi
            var Lastik_Değişimi_Listesi = [];
            $(".preview-images-zone").sortable();

            $(document).on('click', '.image-cancel', function () {
                let no = $(this).data('no');
                $(this).parent().remove();
            });

            var pro_image = $('#pro-image')
            pro_image.change(function () {

                var Resimler = $('div[id=Resim_Div]')
                var Tekrarmı = Resimler.find('div[class*=preview-images-zone]').each(function () { }).length

                if (Tekrarmı < 1) {
                    var myvar = '<div class="col-xs-12" style="padding-bottom:10px">' +
                        '                                <div class="preview-images-zone"  style>' +
                        '                                </div>' +
                        '                            </div>';
                    var Resimler = $('div[id=Resim_Div]')
                    Resimler.append(myvar)
                }
                readImage()
            });

            $('#Lastik_Değişimi_Listesi').dataTable({})

            Lastik_Değişimi_Tablo_Doldur(Lastik_Değişimi_Listesi);
            function Lastik_Değişimi_Tablo_Doldur(Liste_) {
                $('#Lastik_Değişimi_Tablo').empty();

                $('#Lastik_Değişimi_Tablo').append('<table id="Lastik_Değişimi_Tablo_Kendisi" class="display" style="width: 100%">' +
                    '<thead>' +
                    '<tr>' +
                    '<th>Lastik Değişim Tar.</th>' +
                    '<th>Lastik Değişim Kilometresi</th>' +
                    '<th>Tahmini Lastik Kilometresi</th>' +
                    '<th>Resimler</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody id="Lastik_Değişimi_Tablo_Body">' +
                    '</tbody>' +
                    '<tfoot>' +
                    ' <tr>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '<th></th>' +
                    '</tr>' +
                    '</tfoot>' +
                    '</table>'
                );


                if (Liste_.length > 0) {

                    var Tbody = $('tbody[id=Lastik_Değişimi_Tablo_Body]')

                    for (var i = 0; i < Liste_.length; i++) {
                        Tbody.append(
                            '<tr><td>' + Liste_[i].İlaç_Ad + '</td>' +
                            '<td>' + Liste_[i].Adet + '</td>' +
                            '<td>' + Liste_[i].Mf_Adet + '</td>' +
                            '<td>' + Liste_[i].Toplam + '</td>' +
                            '</tr>'
                        )
                    }


                }




                var today = new Date();
                var date = today.getDate() + '/' + (today.getMonth() + 1) + '/' + today.getFullYear();
                var dateTime = date;

                $('#Lastik_Değişimi_Tablo_Kendisi').dataTable({

                    "lengthMenu": [10, 25, 50, 75, 100, 200, 500, 750, 1000],
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.22/i18n/Turkish.json"
                    },

                    "scrollX": true,
                });

            }

            //#endregion


        });



        function readImage() {
            if (window.File && window.FileList && window.FileReader) {
                var files = event.target.files; //FileList object
                var output = $(".preview-images-zone");

                for (let i = 0; i < files.length; i++) {
                    var file = files[i];
                    if (!file.type.match('image')) continue;

                    var picReader = new FileReader();

                    picReader.addEventListener('load', function (event) {
                        var picFile = event.target;
                        var html = '<div class="preview-image preview-show-">' +
                            '<div class="image-cancel">x</div>' +
                            '<div class="image-zone"><img id="pro-img-" src="' + picFile.result + '"></div>' +
                            '</div>';

                        output.append(html);

                    });

                    picReader.readAsDataURL(file);
                }
                $("#pro-image").val('');
            } else {
                console.log('Browser not support');
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <div class="box">
                <div class="box-footer">
                    <div class="row">
                        <div class="col-xs-12">
                            <h4 class="text-center">Araç Bilgileri</h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-xs-12">
                            <label>Araç Plaka</label>
                            <div class="form-group">
                                <input id="Araç_Plaka" class="form-control" disabled />
                            </div>
                        </div>
                        <div class="col-lg-3 col-xs-12">
                            <label>Araç Marka</label>
                            <div class="form-group">
                                <input id="Araç_Marka" class="form-control" disabled />
                            </div>

                        </div>
                        <div class="col-lg-3 col-xs-12">
                            <label>Araç Model</label>
                            <div class="form-group">
                                <input id="Araç_Model" class="form-control" disabled />
                            </div>
                        </div>
                        <div class="col-lg-3 col-xs-12">
                            <label>Araç Kilometre</label>
                            <div class="form-group">
                                <input id="Araç_Kilometre" class="form-control" disabled />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-xs-12">
                            <label>Trafiğe Çıkış Tarihi</label>
                            <div class="form-group">
                                <input id="Araç_Trafiğe_Çıkıt_Tarihi" class="form-control" disabled />
                            </div>
                        </div>
                        <div class="col-lg-3 col-xs-12">
                            <label>Araç Yaşı</label>
                            <div class="form-group">
                                <input id="Araç_Yaşı" class="form-control" disabled />
                            </div>
                        </div>
                        <div class="col-lg-3 col-xs-12">
                            <label>Sonraki Muayne Tar.</label>
                            <div class="form-group">
                                <input id="Araç_Sonraki_Muayne_Tar" class="form-control" disabled />
                            </div>
                        </div>
                        <div class="col-lg-3 col-xs-12">
                            <label>Sonraki Bakım Tar.</label>
                            <div class="form-group">
                                <input id="Araç_Sonraki_Bakım_Tar" class="form-control" disabled />
                            </div>
                        </div>
                        <div class="col-lg-3 col-xs-12">
                            <label>Sonraki Lastik Değişimi :</label>
                            <div class="form-group">
                                <input id="Tahmini_Lastik_Değişimi" class="form-control" disabled />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab_1" data-toggle="tab" aria-expanded="false">Araç Kaza İşlemleri </a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab_1">
                     
                        <div class="row">
                            <div class="col-lg-12 col-xs-12">
                                <label>Kendi ve Karşı Tarafın Belgeleri / Araç Ve Araçların Resimleri </label>
                                <div class="form-group">
                                    <a href="javascript:void(0)" onclick="$('#pro-image').click()" class="btn btn-block btn-default">Fotoğraf Ekle</a>
                                    <input type="file" id="pro-image" name="pro-image" style="display: none;" class="form-control" multiple />
                                </div>
                            </div>
                            <div class="col-xs-12">
                                <div id="Resim_Div"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <input id="Lastik_değişimi_Oluştur" class="btn btn-block btn-primary" type="button" value="Kaydet" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div id="Lastik_Değişimi_Tablo"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
