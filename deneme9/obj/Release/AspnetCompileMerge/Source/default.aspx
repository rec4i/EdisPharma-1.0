<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="kurumsal.kurumsaluser._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.min.css" rel="stylesheet" />
    <!-- iCheck -->
    <link href="plugins/iCheck/square/blue.css" rel="stylesheet" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="login-page">
    <form id="Form1" runat="server">
        <div class="login-box">
            <div class="login-logo">
                <b>EDİS</b>PHARMA
            </div>
            <!-- /.login-logo -->
            <div class="login-box-body">
                <p class="login-box-msg">Giriş</p>
                <form method="post">
                    <div class="form-group has-feedback">
                        <asp:TextBox ID="txt_kullanici" CssClass="form-control" placeholder="Kullanıcı Adı" runat="server"></asp:TextBox>
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>
                    <div class="form-group has-feedback">
                        <asp:TextBox ID="txt_sifre" CssClass="form-control" TextMode="Password" placeholder="Şifre" runat="server"></asp:TextBox>
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>
                    <div class="row">
                        <div class="col-xs-8">
                            <div class="checkbox icheck">
                                <%--<label>
                                    <input type="checkbox" />
                                    Beni Hatırla
                                </label>--%>
                            </div>
                        </div>
                        <div class="col-xs-8">
                            <asp:Panel ID="pnl_ddogru" runat="server">
                            <div class="form-group">
                                <div class="alert alert-success alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                    <h4><i class="icon fa fa-check"></i>Girş Yapıldı!</h4>
                                    Başarıyla Giriş Yapıldı...
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="pnl_dyanlis" runat="server">
                            <div class="form-group">
                                <div class="alert alert-danger alert-dismissable">
                                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                    <h4><i class="icon fa fa-ban"></i>Hata!</h4>
                                    Dığru Kullanıcı Adı veya Şifre Giriniz...
                                </div>
                            </div>
                        </asp:Panel>
                        </div>
                        <!-- /.col -->
                        <div class="col-xs-4">
                            <asp:Button runat="server" type="submit" ID="btn_giris" OnClick="btn_giris_Click" CssClass="btn btn-primary btn-block btn-flat" Text="Giriş" />
                        </div>
                        <!-- /.col -->
                    </div>
                </form>
                <%--<div class="social-auth-links text-center">
                <p>- OR -</p>
                <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i>Sign in using Facebook</a>
                <a href="#" class="btn btn-block btn-social btn-google-plus btn-flat"><i class="fa fa-google-plus"></i>Sign in using Google+</a>
            </div>--%>
                <!-- /.social-auth-links -->

                <%--            <a href="#">I forgot my password</a><br />
            <a href="register.html" class="text-center">Register a new membership</a>--%>
            </div>
            <!-- /.login-box-body -->
        </div>
        <!-- /.login-box -->
        <!-- jQuery 2.1.3 -->
        <script src="plugins/jQuery/jQuery-2.1.3.min.js"></script>
        <!-- Bootstrap 3.3.2 JS -->
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <!-- iCheck -->
        <script src="plugins/iCheck/icheck.min.js"></script>
        <script>
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' // optional
                });
            });
    </script>
    </form>
</body>
</html>
