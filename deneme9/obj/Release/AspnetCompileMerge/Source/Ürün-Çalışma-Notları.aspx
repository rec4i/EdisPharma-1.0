<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="Ürün-Çalışma-Notları.aspx.cs" Inherits="deneme9.Ürün_Çalışma_Notları" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/venobox/1.9.3/venobox.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/venobox/1.9.3/venobox.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/3.5.7/jquery.fancybox.min.css" />
    <script type="text/javascript">


        $(document).ready(function () {



            $.ajax({
                url: 'Ürün-Çalışma-Notları.aspx/Urun_Calısma_Notları',
                type: 'POST',
                data: "{'parametre': ''}",
                async: false,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var temp = JSON.parse(data.d)


                    var Urunler = $('div[id=Urunler]')
                    console.log(temp)
                    for (var i = 0; i < temp.length; i++) {
                        var myvar = '<div class="col-sm-6 col-xs-12">' +
                            '        <div class="info-box">' +
                            '            <span class="info-box-icon"><a class="word" href="//docs.google.com/gview?url=http://176.236.238.166' + temp[i].Urun_Dosya_Link+'&embedded=true"">' +
                            '                <img style="height: 90px; width: 90px; border-radius: 2px; margin-top: -10px" src="' + temp[i].Urun_Resim.replace('~', '') + '" /></a></span>' +
                            '            <div class="info-box-content">' +
                            '                <span class="info-box-text" style="font-size: 18px">' + temp[i].Urun_Adı + '</span>' +
                            '                <span class="info-box-number" style="padding-top: 10px"><a href="http://176.236.238.166' + temp[i].Urun_Dosya_Link + '">Sunumu İndirmek İçin Tıklayın' +
                            '                </a></span>' +
                            '                <span class="info-box-number" style="font-size: 12px; padding-top: 2px;">Önzileme İçin Resime Tıklayın</span>' +
                            '            </div>' +
                            '            <!-- /.info-box-content -->' +
                            '        </div>' +
                            '        <!-- /.info-box -->' +
                            '    </div>';
                        Urunler.append(myvar);
                    }

                },// tekrar eklemeyi önlemek için eklenen doktorları tabloya kaydet sonra ona göre listele xd
                error: function () {
                    alert('Talep esnasında sorun oluştu.Yeniden deneyin');
                }
            });
            $(".word").fancybox({
                'width': 700, // or whatever
                'height': 1000,
                'type': 'iframe'
            });

        }); //  ready 
    </script>
    <style>
        .img-hover:hover {
            cursor: move;
            opacity: .5;
        }
    </style>
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
                height: 150px;
                width: 150px;
                position: relative;
                margin-right: 5px;
            }

            .preview-images-zone > .preview-image {
                height: 100%;
                width: 100%;
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
                    color: #000000;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



   

   <div id="Urunler" class="row"></div>

</asp:Content>
