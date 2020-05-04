using System.Web;
using System.Web.Optimization;

namespace ShoppingCMS_V002
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jqueryCore.js").Include(
                "~/assets/plugins/global/plugins.bundle.js",
                "~/assets/js/scripts.bundle.js",
                "~/assets/plugins/custom/fullcalendar/fullcalendar.bundle.js",
                "~/assets/js/pages/dashboard.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/Afra.js").Include(
                "~/assetsAfra/js/jquery.min.js",
                "~/assetsAfra/js/bootstrap.min.js",
                "~/assetsAfra/js/plugins.min.js",
                "~/assetsAfra/js/main-scripts.js"));

            bundles.Add(new StyleBundle("~/assets/Afra.css").Include(
               "~/assetsAfra/css/icons.min.css",
               "~/assetsAfra/css/bootstrap.min.css",
               "~/assetsAfra/css/plugins.min.css",
               "~/assetsAfra/css/colors.css",
               "~/assetsAfra/css/styles.css"
           ));

            bundles.Add(new ScriptBundle("~/bundles/Ckeditor.js").Include(
                "~/assets/js/pages/custom/Plugins/ckeditor/ckeditor.js"
            ));
            bundles.Add(new ScriptBundle("~/bundles/Select2").Include(
                "~/assets/js/pages/crud/forms/widgets/select2.js"
            ));
            bundles.Add(new ScriptBundle("~/bundles/AddProduct.js").Include(
                 "~/assets/js/pages/custom/wizard/wizard-3.js",
                "~/assets/js/pages/crud/forms/widgets/select2.js"));

            bundles.Add(new StyleBundle("~/assets/CoreAdmin.css").Include(

                "~/assets/css/pages/wizard/wizard-3.rtl.css",
                "~/assets/plugins/custom/fullcalendar/fullcalendar.bundle.rtl.css",
                "~/assets/plugins/global/plugins.bundle.rtl.css",
                "~/assets/css/style.bundle.rtl.css",
                "~/assets/css/skins/header/base/light.rtl.css",
                "~/assets/css/skins/header/menu/light.rtl.css",
                "~/assets/css/skins/brand/dark.rtl.css",
                "~/assets/css/skins/aside/dark.rtl.css",
                "~/assets/css/Custome.css"
            ));
            bundles.Add(new StyleBundle("~/assets/Uploader.css").Include(
                "~/assets/plugins/custom/Uploader/UploaderCustome.css"
            ));

            bundles.Add(new StyleBundle("~/assets/Auth.css").Include(
                "~/assets/Auth/fontawesome-free/css/all.min.css",
                "~/assets/Auth/css/MainLoginCss.css",
                "~/assets/Auth/css/panda.css",
                "~/assets/Auth/css/LoginAuthCustomCss.css"
            ));
            bundles.Add(new ScriptBundle("~/bundles/Auth/mainlogin.js").Include(
                "~/assets/Auth/js/mainlogin.js"
            ));
            bundles.Add(new ScriptBundle("~/bundles/Auth/panda.js").Include(
                "~/assets/Auth/js/panda.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/AddProScript.js").Include(
              "~/CustomScript/AddProScript.js"
          ));

            bundles.Add(new ScriptBundle("~/bundles/JsTree.js").Include(
             "~/assets/plugins/custom/jstree/jstree.bundle.js",
             "~/assets/js/pages/components/extended/treeview.js"
         ));

            bundles.Add(new StyleBundle("~/assets/jstree.css").Include(
               "~/assets/plugins/custom/jstree/jstree.bundle.rtl.css"
           ));


            //////OmdehDaran

            bundles.Add(new ScriptBundle("~/bundles/omd/jquery").Include(
                 "~/assetsOMD/plugins/modernizr.custom.js",
                  "~/assetsOMD/plugins/jquery/jquery-1.11.1.min.js",
                  "~/assetsOMD/plugins/bootstrap/js/bootstrap.min.js",
                  "~/assetsOMD/plugins/bootstrap-select/js/bootstrap-select.min.js",
                  "~/assetsOMD/plugins/superfish/js/superfish.min.js",
                  "~/assetsOMD/plugins/prettyphoto/js/jquery.prettyPhoto.js",
                  "~/assetsOMD/plugins/owl-carousel2/owl.carousel.min.js",
                  "~/assetsOMD/plugins/jquery.sticky.min.js",
                  "~/assetsOMD/plugins/jquery.easing.min.js",
                  "~/assetsOMD/plugins/jquery.smoothscroll.min.js",
                  "~/assetsOMD/plugins/smooth-scrollbar.min.js",
                  "~/assetsOMD/js/theme.js",
                  "~/assetsOMD/plugins/jquery.cookie.js",
                  "~/CustomScript/OMD.js"));

            bundles.Add(new StyleBundle("~/Content/omd/css").Include(
                "~/assetsOMD/plugins/bootstrap/css/bootstrap.min.css",
                "~/assetsOMD/plugins/bootstrap/css/bootstrap-rtl.min.css",
                "~/assetsOMD/plugins/bootstrap-select/css/bootstrap-select.min.css",
                "~/assetsOMD/plugins/fontawesome/css/font-awesome.min.css",
                "~/assetsOMD/plugins/prettyphoto/css/prettyPhoto.css",
                "~/assetsOMD/plugins/owl-carousel2/assets/owl.carousel.min.css",
                "~/assetsOMD/plugins/owl-carousel2/assets/owl.theme.default.min.css",
                "~/assetsOMD/plugins/animate/animate.min.css",
                "~/assetsOMD/css/theme.css",
                "~/assetsOMD/css/theme-blue-1.css"));


        }
    }
}
