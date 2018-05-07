$(document).ready(function() {
    
    $.fn.openViewer = function () {
        $(this).submit(function(e) {
            e.preventDefault();
            //Parámetros generales
            var ctxt = $(this).data("ctxt");
            var name = $(this).find('input[name="reportName"]:focus').val();;
            
            //Parámetros de reportes (Estos ids deben existir en el jsp que use este js)
            var id = $("#reportId").val(); //Exclusivo para reporte detallado
            var from = $("#reportFrom").val(); //Exclusivo para reportes de lista
            var to = $("#reportTo").val(); //Exclusivo para reportes de lista
            
            var repoURL = ctxt + "/ReportsServlet?name=" + name + "&id=" + id + "&from=" + from + "&to=" + to;
            var options = {
                pdfOpenParams: {
                        navpanes: 0,
                        toolbar: 0,
                        statusbar: 0,
                        view: "FitV",
                        pagemode: "none",
                        page: 1
                },
                forcePDFJS: true,
                PDFJS_URL: ctxt + "/resources/lib/pdfjs/web/viewer.html"
            };
            var myPDF = PDFObject.embed(repoURL, "#pdfViewer", options);
            $("#modalReport").modal("show");
            return false;
        });
    };
    initObjeRepo();
});

function initObjeRepo()
{
    $("#reportForm").openViewer();
}

//Método para abrir el reporte de detalla de denuncia sin un formulario que envíe el input (usado al crear una nueva denuncia)
function showReport(ctxt, id) {
    var repoURL = ctxt + "/ReportsServlet?name=Generar reporte&id=" + id;
    var options = {
        pdfOpenParams: {
                navpanes: 0,
                toolbar: 0,
                statusbar: 0,
                view: "FitV",
                pagemode: "none",
                page: 1
        },
        forcePDFJS: true,
        PDFJS_URL: ctxt + "/resources/lib/pdfjs/web/viewer.html"
    };
    var myPDF = PDFObject.embed(repoURL, "#pdfViewer", options);
    $("#modalReport").modal("show");
    return false;
}

