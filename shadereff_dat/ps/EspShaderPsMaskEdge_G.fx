float4 g_EdgeColor : register(c186);
float4 g_Rate : register(c185);
sampler g_Sampler0 : register(s0);
sampler g_Sampler1 : register(s1);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float2 r0;
	float4 r1;
	r0.x = -g_EdgeColor.w + i.texcoord1.w;
	r1 = tex2D(g_Sampler1, i.texcoord);
	r0.y = -r1.w + 1;
	r0.x = -r0.x + r0.y;
	r0.y = -r0.y + i.texcoord1.w;
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1 = r1 * i.texcoord1;
	o.xyz = (r0.xxx >= 0) ? g_EdgeColor.xyz : r1.xyz;
	r0.x = r1.w * g_Rate.x;
	r0.x = (r0.y >= 0) ? r0.x : 0;
	r1 = r0.x + -0.001;
	o.w = r0.x;
	clip(r1);

	return o;
}
