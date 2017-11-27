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

        public void Add_ItemToCart(string username, int partid)
        {
            using (var context = new eBikeContext())
            {
                var customer = (from x in context.OnlineCustomers
                                where x.UserName.Equals(username)
                                select x).FirstOrDefault();
                int customerid = customer.OnlineCustomerID;

                var shoppingcart = (from x in context.ShoppingCarts
                                    where x.OnlineCustomerID.Equals(customerid)
                                    select x).FirstOrDefault();

                ShoppingCartItem newitem = null;

                if (shoppingcart == null)
                {
                    //create a new cart
                    shoppingcart = new ShoppingCart();
                    shoppingcart.OnlineCustomerID = customerid;
                    shoppingcart.CreatedOn = DateTime.Now;
                    shoppingcart = context.ShoppingCarts.Add(shoppingcart);
                }
                else
                {
                    //check existing cart for the item

                    newitem = shoppingcart.ShoppingCartItems.SingleOrDefault(x => x.PartID == partid);
                    //this will be null if the item is NOT in the cart
                    if (newitem != null)
                    {
                        throw new Exception("That item is already in your shopping cart.");
                    }
                }
                int shoppingcartid = shoppingcart.ShoppingCartID;
                newitem = new ShoppingCartItem();
                newitem.ShoppingCartID = shoppingcartid;
                newitem.PartID = partid;
                newitem.Quantity = 1;

                context.ShoppingCartItems.Add(newitem);
                context.SaveChanges();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<ShoppingCartListPOCO> ShoppingCartList(string username)
        {
            using (var context = new eBikeContext())
            {
                var customer = (from x in context.OnlineCustomers
                                where x.UserName.Equals(username)
                                select x).FirstOrDefault();
                if (customer == null)
                {
                    return new List<ShoppingCartListPOCO>();
                }
                else
                {
                    int customerid = customer.OnlineCustomerID;

                    var results = from x in context.ShoppingCartItems
                                  where x.ShoppingCart.OnlineCustomerID.Equals(customerid)
                                  select new ShoppingCartListPOCO
                                  {
                                      PartID = x.PartID,
                                      Description = x.Part.Description,
                                      Quantity = x.Quantity,
                                      UnitPrice = x.Part.SellingPrice,
                                      TotalPrice = (x.Quantity) * (x.Part.SellingPrice)
                                  };
                    return results.ToList();
                }
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Coupon> SalesCouponList()
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.Coupons
                              where x.SalesOrService.Equals(1)
                              select x;
                return results.ToList();
            }
        }


    }
}
