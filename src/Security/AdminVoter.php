<?php 

namespace App\Security;
use App\Entity\User;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Authorization\Voter\Voter;

class AdminVoter extends Voter
{
    const ADMIN = 'admin';

    protected function supports(string $attribute, mixed $subject): bool
    {
        if (!in_array($attribute, [self::ADMIN])) {
            return false;
        }

        return true;
    }

    protected function voteOnAttribute(string $attribute, mixed $subject, TokenInterface $token): bool
    {
        $user = $token->getUser();
        if (!$user instanceof User) {
            return false;
        }

        return match($attribute) {
            self::ADMIN => $this->isAdmin($user)
        };
    }

    private function isAdmin(User $user): bool
    {
        return $user instanceof User && in_array('ROLE_ADMIN', $user->getRoles());
    }
}