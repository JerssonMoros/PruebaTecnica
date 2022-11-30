using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Colegio.Pages.Estudiantes
{
    public class SelectController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult Select(string mySelect)
        {
            return View("Index");
        }
    }
}
