PGDMP         %                y         	   trackerDB    13.4    13.4     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394 	   trackerDB    DATABASE     g   CREATE DATABASE "trackerDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Polish_Poland.1250';
    DROP DATABASE "trackerDB";
                postgres    false            �           0    0    DATABASE "trackerDB"    COMMENT     @   COMMENT ON DATABASE "trackerDB" IS 'Database for tracked data';
                   postgres    false    2991            �            1259    16397    logs    TABLE       CREATE TABLE public.logs (
    visited_page text,
    browser text,
    browser_version text,
    language text,
    os text,
    ip text,
    device text,
    user_agent text NOT NULL,
    uuid uuid NOT NULL,
    created_at timestamp with time zone,
    id integer NOT NULL
);
    DROP TABLE public.logs;
       public         heap    postgres    false            �            1259    16412    logs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.logs_id_seq;
       public          postgres    false    200            �           0    0    logs_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;
          public          postgres    false    201            #           2604    16414    logs id    DEFAULT     b   ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);
 6   ALTER TABLE public.logs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            �          0    16397    logs 
   TABLE DATA           �   COPY public.logs (visited_page, browser, browser_version, language, os, ip, device, user_agent, uuid, created_at, id) FROM stdin;
    public          postgres    false    200   �       �           0    0    logs_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.logs_id_seq', 105, true);
          public          postgres    false    201            %           2606    16416    logs logs_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.logs DROP CONSTRAINT logs_pkey;
       public            postgres    false    200            �     x��\]o\��}�E?f��X$���|��f�d7��@@�0�e�J2ɯ�"����^I�u{~���v�U��_�ܼݞ�_^�t����͖І�����7׵]}y������o��� �!�	�����w7WoϾ�����e:wl~�����'}�/7��/7���������淵|wuN��?��}��x��C��p�`8�5�_}-i�)��DC�A�2n�a�sD�)��x�׶����U�6k��M�{��m��6��绋�:��\l��v��^j(��Pո&qu�Hd�#s�����-�-�lt�.{Ȯ?���/�P�3�n�/����ŷ���������o./���oR���;澾������[_n����j��o/�k���͹7�n����O�|�����6�U��]\�9_�����st�F�����X��#����[�N&���؁�/@�
:P`���(���)Й{T?�o����7ש|W��r���_���z]Ϣ����������ݳ��>���G��0Y�����w���]g2�|UQb3\P=��͔���JȻ�7���gRw�ax
88A��l*�3^Ld�Krs�2���6��8��h��p
8�(�Ihf�M�'F*XS�1̵�8@�ֹ-�)��m�8ȧQR@���M�y�7�����ρ���� �J�,T���@R��@�`�.|87�[�-�{���X4h��M7����?"4i%زL�y�a����Sv�ɑi�a�E�q�"�QŜs���?�qT��[⭃�k�D��8��~���&V���&Ǻ�#��=#�J�@I���)g1#�t�\V�sZ���!��#4�{�gQ5��2b�#9&#���"�1}�6��F��c��/�x��S�>�{�n6V|��>�Ye� &a�ǲO�"�n����]l#��0�6����8z��x�0�nln�A����P���w��kVU-����QVk=��r6�Ϊ�JeU�;?��L<F��n�i�e���^�@�����^b�I�ȣW���z�lS�-��s�l�G��g����`dj��X	���V�����"�q��K,NG���q�Z;E!�< �/I#��p�Q#A�F�]4s�9��?���<�u[+�r�\s=�Ez�N�Pch���J`��p�-X'Y��`ʽ5(��ܬ��cGbn#�?{�>�:�Q��N5�HU�!Z���<�9�Њ��&g��s+���R�g�5+�b��-�{�q`�nP1o{F��rpU:H�Vb����gE'k�;-�2(�|�js�A����%��(�z�4��.s�e��(/@Ϛ����hO�k��ŉ�����g�)
��0܂2��4(��2�M6.���D�
:j�:O�z?z
0*_�8}��-hV��R?ȷ�RX�_/�I��I)���Iy��~��~R��u}���I�i�A��9R�~<fpŸ�T�cRV�ٛ�z\�ID����aM{�ԫ.�������8a(I���*/]1��z�p�s�9���(�[��!.�(�pz��!yD)�wU��5bA#�ԙ�O��]e�]��|@���ۇӻz���.��a��]���J"�22�Nq��F� b!,�iO�r�ơ�J٪���èF�J�
�S!�;Jև��[�u���8}3��G
�EQ�9��Sc\�q��ؖ��8u5����=��7�ܒ�U"�`UX��ۓ|z^���ZA��H�F��Z+#����Z����r?�H�'��&ݓ�ZISa@�bP�"�p��s�35�sj�����Q[�^[�����=��Ͽ���[TB��
��(�<`�Xߟ����.�L��__����/7w^�r�����rC�_���r>�÷�RW@P?��������"V��$��������.=��S�6ޕ �zi��1ۥ���ɣd)[�@��s4�m0��f�R)�9����<�
5���˖�w0�nh�\�\���E���L�s3bֽ@�W���C����&4j��D5�ލ#_���鹊��NLY������tg�[!�T4�:��EAR'�	Jk��la�T�����-��G� q��)�%������y�x��RD����iG���v���@��P/;jO��y�'+�:Y?�@�7���	�u{lJ^K�F���QiMg��-�V�+�Jfp�^	��t��W?N�� ���s�z �F�]az�;�\�#$"��+�q�zĊ�G/�?ޅ��m8�ި��4z!.��X�#��mݩ��M�����K���X�q�=Y�F��Y�njݡֲ�YG�oL���7�~O���W��|�=�c�օ)�W��,+��k�����V`�v�bn�p�C�%�l�_�]0��mC:NdT���۪l\f�uS���@�� R�8�Z��K�����F�C	��R�g�i<�ٶH�̑�5+���9�T����w������B�#MQ�Sb2S&̱+m���	��<1$�H��Q9as9�xk%sj�K)S)+�G�L
��4;G)`��g���Zc��x�j%@� sc�j)�LlYL�J��e�\��)S��;�r�`a���v�[�֪m����|m������(��[(�����b8�P��+Ye[fǎ4�q7�f��R� ���9�"��G�m�x���}{K+��3�e�_�Þ)˵���#e\bP��7٣��`s�%��9�	[R6��m�`v�?{��f��䂽XU�IIr�P|��e��Ы��y�~S�[[�|>֗0'�Hw��la��� &�K>b���y���������g���r��`{���
JBT�v��0�����b32r�S� ���JOqk,�u�r��mPjb;}k��=��I*'�{�D�#�2E	n�W��"�i!���t�b��6��?-pu�O٣c����n��a�P5Ɓ��eP���F�z��pM��L����{�U,)���9+e�Q}x����ks��B�{�H��gUG�C��C��)|���Xd�PD.���=��xU7X7�{
�g�",7��u3�'"Ч�����="��v߸n&�d�8�,⺙ܓp��.ד>lR���I�;Fz��b&��L&�Tc!��%#�M����������y���?i�պϹ����ֹ�,�xo���a��Hk��T��kNw��S�_�7.f�=>i���A��r����Ϻ+<8�|������6�=P�) �R���vX`�����φ�#��A	(*�g�}ۢ�I��i�!��� ��
!i��I\�ݙ\�	SQy�$�O�p���G,r��
��
�lMQqh8���T.:��3̔d/��[2|�,���1�� Q��I�
e?�jC�`��P,���bq�)�)F�k����St·WS�{�?Ӌ/�����     