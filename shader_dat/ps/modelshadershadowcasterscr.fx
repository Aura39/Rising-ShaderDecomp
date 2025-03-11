float g_ShadowFarInv : register(c184);

float4 main(float3 texcoord1 : TEXCOORD1) : COLOR
{
	float4 o;

	float4 r0;
	r0 = g_ShadowFarInv.x + -abs(texcoord1.z);
	clip(r0);
	r0.x = abs(texcoord1.z);
	o.x = -r0.x + 1;
	o.yzw = float3(1, 0, 0);

	return o;
}
