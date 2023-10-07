<?php

namespace App\Controller;

use App\Entity\Product;
use App\Repository\ProductRepository;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\ExpressionLanguage\Expression;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/cart', name: 'cart_')]
#[IsGranted(
    attribute: new Expression("is_granted('ROLE_USER')")
)]
class CartController extends AbstractController
{

    #[Route('/', name: 'index')]
    public function index(SessionInterface $session, ProductRepository $productRepository): Response
    {
        $cart = $session->get('cart', []);

        $total = 0;
        $products = [];
        foreach ($cart as $productId) {
            $product = $productRepository->find($productId);

            $products[] = $product;
            $total += $product->getPrice();
        }

        return $this->render('cart/index.html.twig', compact('products', 'total'));
    }


    #[Route('/add/{id}', name: 'add')]
    public function add(SessionInterface $session, Product $product, UserRepository $userRepository): Response
    {
        $id = $product->getId();

        $userProducts = $userRepository->find($this->getUser())->getProducts();

        $userProductsId = [];
        foreach ($userProducts as $userProduct) {
            $userProductsId[] = $userProduct->getId();
        }


        $cart = $session->get('cart', []);

        if (!in_array($id, $cart) && !in_array($id, $userProductsId)) {
            $cart[] = $id;

            $this->addFlash(
                'success',
                'Produit ajouté avec succès'
            );
        } else {
            $this->addFlash(
                'warning',
                'Vous possédez déjà ce contenu'
            );
        }

        $session->set('cart', $cart);
        return $this->redirectToRoute("cart_index");
    }


    #[Route('/remove/{id}', name: 'remove')]
    public function remove(SessionInterface $session, Product $product): Response
    {
        $id = $product->getId();
        $productTitle = $product->getTitle();

        $cart = $session->get('cart', []);

        if (($key = array_search($id, $cart)) !== false) {
            unset($cart[$key]);
        }

        $session->set('cart', $cart);

        $this->addFlash(
            'success',
            'Produit ' . $productTitle . ' retiré du panier'
        );

        return $this->redirectToRoute("cart_index");
    }

    #[Route('/empty', name: 'empty')]
    public function empty(SessionInterface $session): Response
    {
        $session->remove('cart');
        
        $this->addFlash(
            'success',
            'Votre panier a été vidé'
        );

        return $this->redirectToRoute("cart_index");
    }
}
