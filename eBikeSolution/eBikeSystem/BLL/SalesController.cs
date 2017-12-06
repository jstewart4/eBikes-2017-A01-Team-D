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
        }//CategoryList

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
        }//Parts_byCategoryList

        public void Add_ItemToCart(string username, int partid, int quantity)
        {
            using (var context = new eBikeContext())
            {
                var customer = (from x in context.OnlineCustomers
                                where x.UserName.Equals(username)
                                select x).FirstOrDefault();
                if (customer == null)
                {
                    var sysmgr = new OnlineUsersController();
                    sysmgr.Add_OnlineCustomer(username);

                    customer = (from x in context.OnlineCustomers
                                    where x.UserName.Equals(username)
                                    select x).FirstOrDefault();
                }

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
                newitem.Quantity = quantity;

                context.ShoppingCartItems.Add(newitem);
                context.SaveChanges();
            }
        }//Add_ItemToCart

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
        }//ShoppingCartList

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
        }//SalesCouponList

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public TotalPricePOCO ShoppingCart_Totals(string username)
        {
            using (var context = new eBikeContext())
            {
                var totals = new TotalPricePOCO();

                var customer = (from x in context.OnlineCustomers
                                where x.UserName.Equals(username)
                                select x).FirstOrDefault();

                if (customer == null)
                {
                    totals.SubTotal = 0;
                    totals.GST = 0;
                    totals.Total = 0;
                }
                else
                {
                    int customerid = customer.OnlineCustomerID;

                    var shoppingcart = (from x in context.ShoppingCarts
                                        where x.OnlineCustomerID.Equals(customerid)
                                        select x).FirstOrDefault();

                    var sum = (from x in context.ShoppingCartItems
                               where x.ShoppingCartID == shoppingcart.ShoppingCartID
                               select (x.Quantity * x.Part.SellingPrice)).Sum();

                    totals.SubTotal = sum;
                    totals.GST = Decimal.Multiply(sum, decimal.Parse("0.05"));
                    totals.Total = totals.SubTotal + totals.GST;
                }

                return totals;
            }

                    
        }//ShoppingCartTotals

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public FinalTotalPOCO ShoppingCart_FinalTotals(string username)
        {
            using (var context = new eBikeContext())
            {
                var totals = new FinalTotalPOCO();

                var customer = (from x in context.OnlineCustomers
                                where x.UserName.Equals(username)
                                select x).FirstOrDefault();

                if (customer == null)
                {
                    totals.SubTotal = 0;
                    totals.Discount = 0;
                    totals.GST = 0;
                    totals.Total = 0;
                }
                else
                {
                    int customerid = customer.OnlineCustomerID;

                    var shoppingcart = (from x in context.ShoppingCarts
                                        where x.OnlineCustomerID.Equals(customerid)
                                        select x).FirstOrDefault();

                    var sum = (from x in context.ShoppingCartItems
                               where x.ShoppingCartID == shoppingcart.ShoppingCartID
                               select (x.Quantity * x.Part.SellingPrice)).Sum();

                    totals.SubTotal = sum;
                    totals.Discount = 0;
                    totals.GST = Decimal.Multiply(sum, decimal.Parse("0.05"));
                    totals.Total = totals.SubTotal + totals.GST;
                }

                return totals;
            }
        }//ShoppingCart_FinalTotals

        public void Update_CartItem(string username, int partid, int quantity)
        {
            using (var context = new eBikeContext())
            {
                int customerid = (from x in context.OnlineCustomers
                                where x.UserName.Equals(username)
                                select x.OnlineCustomerID).FirstOrDefault();


                int shoppingcartid = (from x in context.ShoppingCarts
                                    where x.OnlineCustomerID.Equals(customerid)
                                    select x.ShoppingCartID).FirstOrDefault();


                int updateItemID =  (from x in context.ShoppingCartItems
                                  where x.ShoppingCartID.Equals(shoppingcartid) && x.PartID.Equals(partid)
                                  select x.ShoppingCartItemID).FirstOrDefault();

                var updateItem = context.ShoppingCartItems.Find(updateItemID);
                if (updateItem == null)
                {
                    throw new Exception("Item is nullll");
                }
                updateItem.Quantity = quantity;

                context.Entry(updateItem).Property(y => y.Quantity).IsModified = true;

                context.SaveChanges();
            }
        }//Update_CartItem

        public void Remove_CartItem(string username, int partid)
        {
            using (var context = new eBikeContext())
            {
                int customerid = (from x in context.OnlineCustomers
                                  where x.UserName.Equals(username)
                                  select x.OnlineCustomerID).FirstOrDefault();


                int shoppingcartid = (from x in context.ShoppingCarts
                                      where x.OnlineCustomerID.Equals(customerid)
                                      select x.ShoppingCartID).FirstOrDefault();

                int shoppingcartitemid = (from x in context.ShoppingCartItems
                              where x.ShoppingCartID.Equals(shoppingcartid) && x.PartID.Equals(partid)
                              select x.ShoppingCartItemID).FirstOrDefault();

                var existingItem = context.ShoppingCartItems.Find(shoppingcartitemid);

                context.ShoppingCartItems.Remove(existingItem);

                context.SaveChanges();

            }
        }//Remove_CartItem

    }
}
