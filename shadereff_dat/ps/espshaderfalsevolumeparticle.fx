sampler g_Sampler0 : register(s0);

struct PS_IN
{
	float4 texcoord7 : TEXCOORD7;
	float2 texcoord : TEXCOORD;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	r0 = tex2D(g_Sampler0, i.texcoord);
	o = r0 * i.texcoord7;

	return o;
}
