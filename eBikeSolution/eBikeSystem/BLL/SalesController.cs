using eBike.Data.Entities;
using eBike.Data.POCOs;
using eBikeSystem.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBikeSystem.BLL
{
    [DataObject]
    public class SalesController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<CategoryListPOCO> CategoryList()
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.Categories
                              select new CategoryListPOCO
                              {
                                  CategoryID = x.CategoryID,
                                  Description = x.Description
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PartsListPOCO> Parts_byCategoryList(int categoryid)
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.Parts
                              where x.Category.CategoryID == categoryid
                              select new PartsListPOCO
                              {
                                  PartID = x.PartID,
                                  Description = x.Description,
                                  InStock = x.QuantityOnHand,
                                  Price = x.SellingPrice
                              };
                return results.ToList();
            }
        }
    }
}
