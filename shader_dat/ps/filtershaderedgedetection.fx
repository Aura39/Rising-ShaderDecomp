sampler g_Sampler0 : register(s0);
float4 g_TargetUvParam : register(c194);
float4 g_rangeRate : register(c184);

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	r0.x = g_rangeRate.y + g_rangeRate.y;
	r0.yz = g_TargetUvParam.xy + texcoord.xy;
	r1.xy = g_TargetUvParam.xy * r0.xx + r0.yz;
	r1 = tex2D(g_Sampler0, r1);
	r2 = tex2D(g_Sampler0, r0.yzzw);
	r0.w = r1.x + -r2.x;
	r1.x = r2.x * 13333.333 + 1;
	r1.y = g_rangeRate.x * -r1.x + abs(r0.w);
	r1.z = (-r1.y >= 0) ? 0 : 1;
	r1.y = (r1.y >= 0) ? -0 : -1;
	r1.y = r1.y + r1.z;
	r3.x = g_rangeRate.x;
	r1.z = r3.x * 1000;
	r1.z = 1 / r1.z;
	r0.w = abs(r0.w) * r1.z;
	r0.w = r0.w * r1.y;
	r0.w = (r1.y >= 0) ? r0.w : 0;
	r3.z = 0;
	r3.xy = r0.xx * g_TargetUvParam.xy;
	r1.yw = g_TargetUvParam.xy * -r0.xx + r0.yz;
	r4 = tex2D(g_Sampler0, r1.ywzw);
	r0.x = -r2.x + r4.x;
	r4 = r0.yzyz + r3.zyxz;
	r5 = r3.xzzy * float4(-1, 1, 1, -1) + r0.yzyz;
	r6 = tex2D(g_Sampler0, r4);
	r4 = tex2D(g_Sampler0, r4.zwzw);
	r1.y = -r2.x + r4.x;
	r1.w = -r2.x + r6.x;
	r2.y = g_rangeRate.x * -r1.x + abs(r1.w);
	r1.w = r1.z * abs(r1.w);
	r2.z = (-r2.y >= 0) ? 0 : 1;
	r2.y = (r2.y >= 0) ? -0 : -1;
	r2.y = r2.y + r2.z;
	r1.w = r1.w * r2.y;
	r1.w = (r2.y >= 0) ? r1.w : 0;
	r0.w = r0.w + r1.w;
	r1.w = g_rangeRate.x * -r1.x + abs(r1.y);
	r1.y = r1.z * abs(r1.y);
	r2.y = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.y;
	r1.y = r1.y * r1.w;
	r1.y = (r1.w >= 0) ? r1.y : 0;
	r0.w = r0.w + r1.y;
	r3.w = -r3.x;
	r1.yw = r0.yz + r3.wy;
	r0.yz = r3.xy * float2(0, 1) + r0.yz;
	r3 = tex2D(g_Sampler0, r0.yzzw);
	r0.y = -r2.x + r3.x;
	r3 = tex2D(g_Sampler0, r1.ywzw);
	r0.z = -r2.x + r3.x;
	r1.y = g_rangeRate.x * -r1.x + abs(r0.z);
	r0.z = r1.z * abs(r0.z);
	r1.w = (-r1.y >= 0) ? 0 : 1;
	r1.y = (r1.y >= 0) ? -0 : -1;
	r1.y = r1.y + r1.w;
	r0.z = r0.z * r1.y;
	r0.z = (r1.y >= 0) ? r0.z : 0;
	r0.z = r0.z + r0.w;
	r3 = tex2D(g_Sampler0, r5);
	r4 = tex2D(g_Sampler0, r5.zwzw);
	r0.w = -r2.x + r4.x;
	r1.y = -r2.x + r3.x;
	r2.x = r2.x * 333.33334;
	r2.x = r2.x;
	r1.w = r2.x + -0.9;
	r1.w = r1.w * -10 + 1;
	r2.x = r1.z * abs(r1.y);
	r1.y = g_rangeRate.x * -r1.x + abs(r1.y);
	r2.y = (-r1.y >= 0) ? 0 : 1;
	r1.y = (r1.y >= 0) ? -0 : -1;
	r1.y = r1.y + r2.y;
	r2.x = r2.x * r1.y;
	r1.y = (r1.y >= 0) ? r2.x : 0;
	r0.z = r0.z + r1.y;
	r1.y = r1.z * abs(r0.x);
	r0.x = g_rangeRate.x * -r1.x + abs(r0.x);
	r2.x = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r2.x;
	r1.y = r1.y * r0.x;
	r0.x = (r0.x >= 0) ? r1.y : 0;
	r0.x = r0.x + r0.z;
	r0.z = r1.z * abs(r0.w);
	r0.w = g_rangeRate.x * -r1.x + abs(r0.w);
	r1.x = g_rangeRate.x * -r1.x + abs(r0.y);
	r0.y = r1.z * abs(r0.y);
	r1.y = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.y;
	r0.z = r0.z * r0.w;
	r0.z = (r0.w >= 0) ? r0.z : 0;
	r0.x = r0.z + r0.x;
	r0.z = (-r1.x >= 0) ? 0 : 1;
	r0.w = (r1.x >= 0) ? -0 : -1;
	r0.z = r0.w + r0.z;
	r0.y = r0.y * r0.z;
	r0.y = (r0.z >= 0) ? r0.y : 0;
	r0.x = r0.y + r0.x;
	r0.x = r0.x * 3;
	o.w = r1.w * r0.x;
	o.xyz = float3(0.25, 0.75, 0.75);

	return o;
}
