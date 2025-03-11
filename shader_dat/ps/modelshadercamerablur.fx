float3 g_CameraSpeed : register(c184);
sampler g_Sampler0 : register(s13);
sampler g_Sampler1 : register(s14);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	r0.xy = float2(0.000390625, 0.00069444446) + texcoord.xy;
	r1 = tex2D(g_Sampler0, r0);
	r2 = tex2D(g_Sampler1, r0);
	r3 = r1;
	r0.zw = 1;
	for (int i0 = 0; i0 < 7; i0++) {
		r4.xy = g_CameraSpeed.xy * r0.ww + r0.xy;
		r5 = tex2D(g_Sampler0, r4);
		r4 = tex2D(g_Sampler1, r4);
		r2.w = r2.z + -r4.z;
		r4 = r3 + r5;
		r5.x = r0.z + 1;
		r3 = (r2.w >= 0) ? r4 : r3;
		r0.z = (r2.w >= 0) ? r5.x : r0.z;
		r0.w = r0.w + 1;
	}
	r0.x = 1 / r0.z;
	r0 = r0.x * r3;
	r2.z = (-abs(r2.z) >= 0) ? -1 : -0;
	r2.y = (-abs(r2.y) >= 0) ? r2.z : -0;
	r2.x = (-abs(r2.x) >= 0) ? r2.y : -0;
	o = (r2.x >= 0) ? r1 : r0;

	return o;
}
