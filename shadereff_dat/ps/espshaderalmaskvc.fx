sampler g_Sampler0;
sampler g_Sampler1;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	r0 = tex2D(g_Sampler1, i.texcoord1);
	r1 = tex2D(g_Sampler0, i.texcoord);
	r1.w = r0.w * r1.w;
	o = r1 * i.texcoord7;

	return o;
}
