<?php

namespace App\Controller;

use App\Entity\Order;
use App\Entity\User;
use App\Repository\ProductRepository;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

use function Symfony\Component\Clock\now;

#[IsGranted('ROLE_USER')]
#[Route('/order', name: 'order_')]
class OrderController extends AbstractController
{
    #[Route('/add', name: 'add')]
    public function add(UserRepository $userRepository, SessionInterface $session, ProductRepository $productRepository, EntityManagerInterface $manager): Response
    {
        $user = $userRepository->find($this->getUser());

        $cart = $session->get('cart', []);

        $order = new Order;
        $price = 0;
        foreach($cart as $item) {
            $product = $productRepository->find($item);

            $order->addProduct($product);
            $user->addProduct($product);

            $price += $product->getPrice();
        }
        $order->setCustomer($this->getUser());
        $order->setPrice($price);
        $order->setReference($user->getLastName() . now()->format('YmdHis'));

        $manager->persist($order);
        $manager->flush();

        $session->remove('cart');

        return $this->redirectToRoute('user_index');
    }
}
