<?php

namespace App\Controller;


use App\Form\EditUserType;
use App\Form\EditPasswordType;
use App\Repository\UserRepository;
use App\Repository\OrderRepository;
use Doctrine\ORM\EntityManagerInterface;
use function Symfony\Component\Clock\now;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\ExpressionLanguage\Expression;
use Symfony\Component\Security\Http\Attribute\IsGranted;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;


#[Route('/user', name: 'user_')]
#[IsGranted(
    attribute: new Expression("is_granted('ROLE_USER')")
)]
class UserController extends AbstractController
{
    #[Route('/', name: 'index')]
    public function user(): Response
    {
        return $this->render('pages/user/index.html.twig', [
            'user' => $this->getUser()
        ]);
    }

    #[Route('/edit', name: 'edit')]
    public function edit(Request $request, UserRepository $userRepository, UserPasswordHasherInterface $hasher, EntityManagerInterface $manager): Response
    {
        $loggedUser = $userRepository->find($this->getUser());

        $form = $this->createForm(EditUserType::class, $loggedUser);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            if ($hasher->isPasswordValid($loggedUser, $form->getData()->getPlainPassword())) {
                $user = $form->getData();
                $loggedUser->setUpdatedAt(now());

                $manager->persist($user);
                $manager->flush();

                $this->addFlash(
                    'success',
                    'profile modifié avec succès'
                );

                return $this->redirectToRoute('user_edit');
            } else {
                $this->addFlash(
                    'warning',
                    'échec de la modification'
                );

                return $this->redirectToRoute('user_edit');
            }
        }

        return $this->render('pages/user/edit.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/password', name: 'password')]
    public function password(Request $request, UserRepository $userRepository, UserPasswordHasherInterface $hasher, EntityManagerInterface $manager): Response
    {
        $loggedUser = $userRepository->find($this->getUser());

        $form = $this->createForm(EditPasswordType::class, $loggedUser);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            // dd($form->getData());

            if ($hasher->isPasswordValid($loggedUser, $form->getData()->getPlainPassword())) {
                $loggedUser->setPlainPassword($form['newPassword']->getData());
                $loggedUser->setUpdatedAt(now());


                $manager->persist($loggedUser);
                $manager->flush();

                $this->addFlash(
                    'success',
                    'Les informations de votre profil ont été modifiées'
                );

                return $this->redirectToRoute('user_password');
            } else {
                $this->addFlash(
                    'warning',
                    'Mot de passe incorrect'
                );

                return $this->redirectToRoute('user_password');
            }
        }

        return $this->render('pages/user/password.html.twig', [
            'form' => $form,
        ]);
    }

    #[Route('/orders', name: 'orders')]
    public function orders(OrderRepository $orderRepository,): Response
    {

        $orders = $orderRepository->findBy(['customer' => $this->getUser()]);

        // dd($orders);

        return $this->render('pages/user/orders.html.twig', [
            'orders' => $orders,
        ]);
    }


    #[Route('/order/{id}', name: 'order')]
    public function order(OrderRepository $orderRepository, int $id): Response
    {
        $order = $orderRepository->findBy(['id' => $id, 'customer' => $this->getUser()])[0];


        return $this->render('pages/user/order.html.twig', [
            'order' => $order,
        ]);
    }

    #[Route('/products', name: 'products')]
    public function products(UserRepository $userRepository): Response
    {
        $user = $userRepository->find($this->getUser());

        $products = $user->getProducts();


        return $this->render('pages/user/products.html.twig', [
            'products' => $products,
        ]);
    }
}
