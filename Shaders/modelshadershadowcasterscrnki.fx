sampler g_Sampler0;
float g_ShadowFarInv;
float4 g_nkiBase;
float4 g_uvOffset;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	r0.xy = g_uvOffset.xy + i.texcoord.xy;
	r0 = tex2D(g_Sampler0, r0);
	r0 = r0.w + -g_nkiBase.x;
	clip(r0);
	r0 = g_ShadowFarInv.x + -abs(i.texcoord1.z);
	clip(r0);
	r0.x = abs(i.texcoord1.z);
	o.x = -r0.x + 1;
	o.yzw = float3(1, 0, 0);

	return o;
}
