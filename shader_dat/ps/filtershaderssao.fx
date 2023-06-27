sampler g_Sampler0;
sampler g_Sampler1;
sampler g_Sampler2;
float4 g_TargetUvParam;
float4 g_offsetPow;
float3 pSphere;

float4 main(float2 texcoord : TEXCOORD) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
	float4 r5;
	float4 r6;
	r0.xyz = float3(2, 1, 0.5);
	r0.xw = g_TargetUvParam.xy * r0.xy + texcoord.xy;
	r1.xy = g_TargetUvParam.xy * r0.yz + r0.xw;
	r1 = tex2D(g_Sampler0, r1);
	r2.xy = g_TargetUvParam.xy;
	r2 = r2.xyxy * float4(1, -0.5, -1, 0.5) + r0.xwxw;
	r3 = tex2D(g_Sampler0, r2);
	r2 = tex2D(g_Sampler0, r2.zwzw);
	r2.y = max(r1.x, r3.x);
	r0.yz = g_TargetUvParam.xy * -r0.yz + r0.xw;
	r1 = tex2D(g_Sampler0, r0.yzzw);
	r0.y = max(r2.x, r1.x);
	r1.x = max(r2.y, r0.y);
	r0.y = r1.x * 20;
	r0.y = -r0.y + 1;
	r0.y = r0.y * g_offsetPow.x;
	r1.yz = r0.xw * 10;
	r2 = tex2D(g_Sampler2, r1.yzzw);
	r2 = r2 * 2 + -1;
	r0.z = dot(r2, r2);
	r0.z = 1 / sqrt(r0.z);
	r1.yzw = r0.zzz * r2.xyz;
	r0.z = dot(pSphere.xyz, r1.yzw);
	r0.z = r0.z + r0.z;
	r2.xyz = r1.yzw * -r0.zzz + pSphere.xyz;
	r2.xyz = r0.yyy * r2.xyz;
	r3 = tex2D(g_Sampler1, r0.xwzw);
	r3.xyz = r3.xyz * 2 + -1;
	r4.xyz = normalize(r3.xyz);
	r0.z = dot(r2.xyz, r4.xyz);
	r2.z = (-r0.z >= 0) ? 0 : 1;
	r0.z = (r0.z >= 0) ? -0 : -1;
	r0.z = r0.z + r2.z;
	r2.xy = r2.xy * r0.zz;
	r2.xy = r2.xy * float2(1, -1) + r0.xw;
	r5 = tex2D(g_Sampler1, r2);
	r2 = tex2D(g_Sampler0, r2);
	r0.z = r1.x + -r2.x;
	r2.xyz = r5.xyz * 2 + -1;
	r3.xyz = normalize(r2.xyz);
	r2.x = dot(r3.xyz, r4.xyz);
	r2.x = -r2.x + 1;
	r2.y = 1 / g_offsetPow.z;
	r2.z = r0.z * r2.y;
	r0.z = r0.z + -g_offsetPow.y;
	r2.w = r2.z * -2 + 3;
	r2.z = r2.z * r2.z;
	r2.z = r2.w * -r2.z + 1;
	r2.x = r2.z * r2.x;
	r0.z = (r0.z >= 0) ? r2.x : 0;
	r2.x = dot(pSphere.xyz, r1.yzw);
	r2.x = r2.x + r2.x;
	r2.xzw = r1.yzw * -r2.xxx + pSphere.xyz;
	r2.xzw = r0.yyy * r2.xzw;
	r2.w = dot(r2.xzw, r4.xyz);
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.xz = r2.xz * r2.ww;
	r2.xz = r2.xz * 1 + r0.xw;
	r5 = tex2D(g_Sampler1, r2.xzzw);
	r6 = tex2D(g_Sampler0, r2.xzzw);
	r2.x = r1.x + -r6.x;
	r3.xyz = r5.xyz * 2 + -1;
	r5.xyz = normalize(r3.xyz);
	r2.z = dot(r5.xyz, r4.xyz);
	r2.z = -r2.z + 1;
	r2.w = r2.y * r2.x;
	r2.x = r2.x + -g_offsetPow.y;
	r3.x = r2.w * -2 + 3;
	r2.w = r2.w * r2.w;
	r2.w = r3.x * -r2.w + 1;
	r2.z = r2.w * r2.z;
	r2.x = (r2.x >= 0) ? r2.z : 0;
	r0.z = r0.z + r2.x;
	r2.x = dot(pSphere.xyz, r1.yzw);
	r2.x = r2.x + r2.x;
	r2.xzw = r1.yzw * -r2.xxx + pSphere.xyz;
	r2.xzw = r0.yyy * r2.xzw;
	r2.w = dot(r2.xzw, r4.xyz);
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.xz = r2.xz * r2.ww;
	r2.xz = r2.xz * 1 + r0.xw;
	r5 = tex2D(g_Sampler1, r2.xzzw);
	r6 = tex2D(g_Sampler0, r2.xzzw);
	r2.x = r1.x + -r6.x;
	r3.xyz = r5.xyz * 2 + -1;
	r5.xyz = normalize(r3.xyz);
	r2.z = dot(r5.xyz, r4.xyz);
	r2.z = -r2.z + 1;
	r2.w = r2.y * r2.x;
	r2.x = r2.x + -g_offsetPow.y;
	r3.x = r2.w * -2 + 3;
	r2.w = r2.w * r2.w;
	r2.w = r3.x * -r2.w + 1;
	r2.z = r2.w * r2.z;
	r2.x = (r2.x >= 0) ? r2.z : 0;
	r0.z = r0.z + r2.x;
	r2.x = dot(pSphere.xyz, r1.yzw);
	r2.x = r2.x + r2.x;
	r2.xzw = r1.yzw * -r2.xxx + pSphere.xyz;
	r2.xzw = r0.yyy * r2.xzw;
	r2.w = dot(r2.xzw, r4.xyz);
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.xz = r2.xz * r2.ww;
	r2.xz = r2.xz * 1 + r0.xw;
	r5 = tex2D(g_Sampler1, r2.xzzw);
	r6 = tex2D(g_Sampler0, r2.xzzw);
	r2.x = r1.x + -r6.x;
	r3.xyz = r5.xyz * 2 + -1;
	r5.xyz = normalize(r3.xyz);
	r2.z = dot(r5.xyz, r4.xyz);
	r2.z = -r2.z + 1;
	r2.w = r2.y * r2.x;
	r2.x = r2.x + -g_offsetPow.y;
	r3.x = r2.w * -2 + 3;
	r2.w = r2.w * r2.w;
	r2.w = r3.x * -r2.w + 1;
	r2.z = r2.w * r2.z;
	r2.x = (r2.x >= 0) ? r2.z : 0;
	r0.z = r0.z + r2.x;
	r2.x = dot(pSphere.xyz, r1.yzw);
	r2.x = r2.x + r2.x;
	r2.xzw = r1.yzw * -r2.xxx + pSphere.xyz;
	r2.xzw = r0.yyy * r2.xzw;
	r2.w = dot(r2.xzw, r4.xyz);
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.xz = r2.xz * r2.ww;
	r2.xz = r2.xz * 1 + r0.xw;
	r5 = tex2D(g_Sampler1, r2.xzzw);
	r6 = tex2D(g_Sampler0, r2.xzzw);
	r2.x = r1.x + -r6.x;
	r3.xyz = r5.xyz * 2 + -1;
	r5.xyz = normalize(r3.xyz);
	r2.z = dot(r5.xyz, r4.xyz);
	r2.z = -r2.z + 1;
	r2.w = r2.y * r2.x;
	r2.x = r2.x + -g_offsetPow.y;
	r3.x = r2.w * -2 + 3;
	r2.w = r2.w * r2.w;
	r2.w = r3.x * -r2.w + 1;
	r2.z = r2.w * r2.z;
	r2.x = (r2.x >= 0) ? r2.z : 0;
	r0.z = r0.z + r2.x;
	r2.x = dot(pSphere.xyz, r1.yzw);
	r2.x = r2.x + r2.x;
	r2.xzw = r1.yzw * -r2.xxx + pSphere.xyz;
	r2.xzw = r0.yyy * r2.xzw;
	r2.w = dot(r2.xzw, r4.xyz);
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.xz = r2.xz * r2.ww;
	r2.xz = r2.xz * 1 + r0.xw;
	r5 = tex2D(g_Sampler1, r2.xzzw);
	r6 = tex2D(g_Sampler0, r2.xzzw);
	r2.x = r1.x + -r6.x;
	r3.xyz = r5.xyz * 2 + -1;
	r5.xyz = normalize(r3.xyz);
	r2.z = dot(r5.xyz, r4.xyz);
	r2.z = -r2.z + 1;
	r2.w = r2.y * r2.x;
	r2.x = r2.x + -g_offsetPow.y;
	r3.x = r2.w * -2 + 3;
	r2.w = r2.w * r2.w;
	r2.w = r3.x * -r2.w + 1;
	r2.z = r2.w * r2.z;
	r2.x = (r2.x >= 0) ? r2.z : 0;
	r0.z = r0.z + r2.x;
	r2.x = dot(pSphere.xyz, r1.yzw);
	r2.x = r2.x + r2.x;
	r2.xzw = r1.yzw * -r2.xxx + pSphere.xyz;
	r2.xzw = r0.yyy * r2.xzw;
	r2.w = dot(r2.xzw, r4.xyz);
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.xz = r2.xz * r2.ww;
	r2.xz = r2.xz * 1 + r0.xw;
	r5 = tex2D(g_Sampler1, r2.xzzw);
	r6 = tex2D(g_Sampler0, r2.xzzw);
	r2.x = r1.x + -r6.x;
	r3.xyz = r5.xyz * 2 + -1;
	r5.xyz = normalize(r3.xyz);
	r2.z = dot(r5.xyz, r4.xyz);
	r2.z = -r2.z + 1;
	r2.w = r2.y * r2.x;
	r2.x = r2.x + -g_offsetPow.y;
	r3.x = r2.w * -2 + 3;
	r2.w = r2.w * r2.w;
	r2.w = r3.x * -r2.w + 1;
	r2.z = r2.w * r2.z;
	r2.x = (r2.x >= 0) ? r2.z : 0;
	r0.z = r0.z + r2.x;
	r2.x = dot(pSphere.xyz, r1.yzw);
	r2.x = r2.x + r2.x;
	r1.yzw = r1.yzw * -r2.xxx + pSphere.xyz;
	r1.yzw = r0.yyy * r1.yzw;
	r0.y = dot(r1.yzw, r4.xyz);
	r1.w = (-r0.y >= 0) ? 0 : 1;
	r0.y = (r0.y >= 0) ? -0 : -1;
	r0.y = r0.y + r1.w;
	r1.yz = r1.yz * r0.yy;
	r0.xy = r1.yz * float2(1, -1) + r0.xw;
	r5 = tex2D(g_Sampler1, r0);
	r6 = tex2D(g_Sampler0, r0);
	r0.x = r1.x + -r6.x;
	r1.yzw = r5.xyz * 2 + -1;
	r3.xyz = normalize(r1.yzw);
	r0.y = dot(r3.xyz, r4.xyz);
	r0.y = -r0.y + 1;
	r0.w = r2.y * r0.x;
	r0.x = r0.x + -g_offsetPow.y;
	r1.y = r0.w * -2 + 3;
	r0.w = r0.w * r0.w;
	r0.w = r1.y * -r0.w + 1;
	r0.y = r0.w * r0.y;
	r0.x = (r0.x >= 0) ? r0.y : 0;
	r0.x = r0.x + r0.z;
	r0.x = r0.x * g_offsetPow.w;
	r0.y = r1.x + -0.1;
	o.w = r1.x;
	r0.y = (-r0.y >= 0) ? 0 : 1;
	r0.x = r0.x * 0.125 + r0.y;
	o.xyz = r0.xxx * -r3.www + 1;

	return o;
}